locals {
  descriptive_name = "${var.prefix}-${formatdate("YYYYMMDD-HHmmss", timestamp())}"
  
  parent_type = var.parent == null ? null : split("/", var.parent)[0]
  parent_id   = var.parent == null ? null : split("/", var.parent)[1]
  prefix      = var.prefix == null ? "" : "${var.prefix}-"
  project = (
    var.project_create ?
    {
      project_id = try(google_project.project[0].project_id, null)
      number     = try(google_project.project[0].number, null)
      name       = try(google_project.project[0].name, null)
    }
    : {
      project_id = "${local.prefix}${var.name}"
      number     = try(data.google_project.project[0].number, null)
      name       = try(data.google_project.project[0].name, null)
    }
  )
}

data "google_project" "project" {
  count      = var.project_create ? 0 : 1
  project_id = "${local.prefix}${var.name}"
}

resource "google_project" "project" {
  count               = var.project_create ? 1 : 0
  org_id              = local.parent_type == "organizations" ? local.parent_id : null
  folder_id           = local.parent_type == "folders" ? local.parent_id : null
  project_id          = "${local.prefix}${var.name}"
  name                = local.descriptive_name
  billing_account     = var.billing_account
  auto_create_network = var.auto_create_network
  labels              = var.labels
  skip_delete         = var.skip_delete
}

resource "google_project_service" "project_services" {
  for_each                   = toset(var.services)
  project                    = local.project.project_id
  service                    = each.value
  disable_on_destroy         = var.service_config.disable_on_destroy
  disable_dependent_services = var.service_config.disable_dependent_services
  depends_on                 = [google_org_policy_policy.default]
}

resource "google_compute_project_metadata_item" "default" {
  for_each = (
    contains(var.services, "compute.googleapis.com") ? var.compute_metadata : {}
  )
  project    = local.project.project_id
  key        = each.key
  value      = each.value
  depends_on = [google_project_service.project_services]
}

resource "google_resource_manager_lien" "lien" {
  count        = var.lien_reason != null ? 1 : 0
  parent       = "projects/${local.project.number}"
  restrictions = ["resourcemanager.projects.delete"]
  origin       = "created-by-terraform"
  reason       = var.lien_reason
}

resource "google_essential_contacts_contact" "contact" {
  provider                            = google-beta
  for_each                            = var.contacts
  parent                              = "projects/${local.project.project_id}"
  email                               = each.key
  language_tag                        = "en"
  notification_category_subscriptions = each.value
  depends_on = [
    google_project_iam_binding.authoritative,
    google_project_iam_binding.bindings,
    google_project_iam_member.bindings
  ]
}

resource "google_monitoring_monitored_project" "primary" {
  provider      = google-beta
  for_each      = toset(var.metric_scopes)
  metrics_scope = each.value
  name          = local.project.project_id
}

# resource "google_storage_bucket" "log_bucket" {
#   name          = "${var.log_bucket_name}ibb"
#   location      = var.region
#   project       = local.project.project_id
#   storage_class = "STANDARD"

#   versioning {
#     enabled = true
#   }

#   lifecycle_rule {
#     action {
#       type = "Delete"
#     }
#     condition {
#       age = 365
#     }
#   }

#   labels = {
#     environment = "production"
#     purpose     = "logging"
#   }

#   uniform_bucket_level_access = true
# }

# resource "google_storage_bucket" "terraform_state" {
#   name          = "${var.bucket_name}ibb"
#   location      = var.region
#   project       = local.project.project_id
#   storage_class = "STANDARD"
#   force_destroy = true

#   # versioning {
#   #   enabled = true
#   # }

#   lifecycle_rule {
#     action {
#       type          = "SetStorageClass"
#       storage_class = "NEARLINE"
#     }
#     condition {
#       age                   = 365
#       matches_storage_class = ["STANDARD", "DURABLE_REDUCED_AVAILABILITY"]
#     }
#   }

#   lifecycle_rule {
#     action {
#       type          = "SetStorageClass"
#       storage_class = "COLDLINE"
#     }
#     condition {
#       age                   = 1095
#       matches_storage_class = ["NEARLINE"]
#     }
#   }

#   lifecycle_rule {
#     action {
#       type          = "SetStorageClass"
#       storage_class = "ARCHIVE"
#     }
#     condition {
#       age                   = 1825
#       matches_storage_class = ["COLDLINE"]
#     }
#   }

#   lifecycle_rule {
#     action {
#       type = "Delete"
#     }
#     condition {
#       age    = 2555
#     }
#   }

#   uniform_bucket_level_access = true

#   logging {
#     log_bucket        = google_storage_bucket.log_bucket.name
#     log_object_prefix = "logs/"
#   }

#   # encryption {
#   #   default_kms_key_name = var.kms_key_name
#   # }

#   retention_policy {
#     retention_period = 365 * 3 // 3 years
#   }

#   labels = {
#     environment = "production"
#     purpose     = "terraform-state"
#   }

#   depends_on = [
#     google_project.project,
#     google_storage_bucket.log_bucket
#   ]
# }

# resource "google_project_iam_binding" "storage_admin" {
#   project = local.project.project_id
#   role    = "roles/storage.admin"

#   members = [
#     "serviceAccount:${var.service_account_email}"
#   ]
# }

# resource "google_storage_bucket_iam_binding" "no_public_access" {
#   bucket = google_storage_bucket.terraform_state.name
#   role   = "roles/storage.objectViewer"

#   members = [
#     "serviceAccount:${var.service_account_email}"
#   ]

#   condition {
#     title       = "No public access"
#     description = "Prevent public access"
#     expression  = "request.auth != null"
#   }
# }

# resource "google_storage_bucket_iam_member" "internal_only" {
#   bucket = google_storage_bucket.terraform_state.name
#   role   = "roles/storage.objectViewer"
#   member = "serviceAccount:${var.internal_service_account_email}"
# }
