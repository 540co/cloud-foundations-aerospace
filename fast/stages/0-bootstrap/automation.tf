locals {
  cicd_resman_sa   = try(module.automation-tf-cicd-sa["resman"].iam_email, "")
  cicd_resman_r_sa = try(module.automation-tf-cicd-r-sa["resman"].iam_email, "")
  
  # Use the prefix directly
  descriptive_name = var.prefix
}

module "automation-project" {
  source                            = "../../../modules/project"
  billing_account                   = var.billing_account.id
  name                              = "iac-core-0"
  project_id                        = "iac-core-0"
  parent                            = coalesce(var.project_parent_ids.automation, var.organization_id)
  prefix                            = local.prefix
  organization_id                   = var.organization_id
  contacts                          = (var.bootstrap_user != null || var.essential_contacts == null ? {} : { (var.essential_contacts) = ["ALL"] })
  iam_by_principals                 = {
    (local.principals.gcp-devops)   = ["roles/iam.serviceAccountAdmin", "roles/iam.serviceAccountTokenCreator"]
    (local.principals.gcp-organization-admins) = ["roles/iam.serviceAccountTokenCreator", "roles/iam.workloadIdentityPoolAdmin"]
  }
  iam = {
    "roles/browser"                                = [module.automation-tf-resman-r-sa.iam_email]
    "roles/owner"                                  = [module.automation-tf-bootstrap-sa.iam_email]
    "roles/cloudbuild.builds.editor"               = [module.automation-tf-resman-sa.iam_email]
    "roles/cloudbuild.builds.viewer"               = [module.automation-tf-resman-r-sa.iam_email]
    "roles/iam.serviceAccountAdmin"                = [module.automation-tf-resman-sa.iam_email]
    "roles/iam.serviceAccountViewer"               = [module.automation-tf-resman-r-sa.iam_email]
    "roles/iam.workloadIdentityPoolAdmin"          = [module.automation-tf-resman-sa.iam_email]
    "roles/iam.workloadIdentityPoolViewer"         = [module.automation-tf-resman-r-sa.iam_email]
    "roles/source.admin"                           = [module.automation-tf-resman-sa.iam_email]
    "roles/source.reader"                          = [module.automation-tf-resman-r-sa.iam_email]
    "roles/storage.admin"                          = [module.automation-tf-resman-sa.iam_email]
    (module.organization.custom_role_id["storage_viewer"]) = [
      module.automation-tf-bootstrap-r-sa.iam_email,
      module.automation-tf-resman-r-sa.iam_email
    ]
    "roles/viewer" = [
      module.automation-tf-bootstrap-r-sa.iam_email,
      module.automation-tf-resman-r-sa.iam_email
    ]
  }
  iam_bindings = {
    delegated_grants_resman = {
      members   = [module.automation-tf-resman-sa.iam_email]
      role      = "roles/resourcemanager.projectIamAdmin"
      condition = {
        title       = "resman_delegated_grant"
        description = "Resource manager service account delegated grant."
        expression  = format("api.getAttribute('iam.googleapis.com/modifiedGrantsByRole', []).hasOnly(['%s'])", "roles/serviceusage.serviceUsageConsumer")
      }
    }
  }
  iam_bindings_additive = {
    serviceusage_resman = {
      member = module.automation-tf-resman-sa.iam_email
      role   = "roles/serviceusage.serviceUsageConsumer"
    }
    serviceusage_resman_r = {
      member = module.automation-tf-resman-r-sa.iam_email
      role   = "roles/serviceusage.serviceUsageViewer"
    }
  }
  org_policies = var.bootstrap_user != null ? {} : {
    "compute.skipDefaultNetworkCreation"            = { rules = [{ enforce = true }] }
    "iam.automaticIamGrantsForDefaultServiceAccounts" = { rules = [{ enforce = true }] }
    "iam.disableServiceAccountKeyCreation"           = { rules = [{ enforce = true }] }
  }
  services = concat(
    [
      "accesscontextmanager.googleapis.com",
      "bigquery.googleapis.com",
      "bigqueryreservation.googleapis.com",
      "bigquerystorage.googleapis.com",
      "billingbudgets.googleapis.com",
      "cloudasset.googleapis.com",
      "cloudbilling.googleapis.com",
      "cloudkms.googleapis.com",
      "cloudquotas.googleapis.com",
      "cloudresourcemanager.googleapis.com",
      "essentialcontacts.googleapis.com",
      "iam.googleapis.com",
      "iamcredentials.googleapis.com",
      "orgpolicy.googleapis.com",
      "pubsub.googleapis.com",
      "servicenetworking.googleapis.com",
      "serviceusage.googleapis.com",
      "sourcerepo.googleapis.com",
      "stackdriver.googleapis.com",
      "storage-component.googleapis.com",
      "storage.googleapis.com",
      "sts.googleapis.com"
    ],
    var.bootstrap_user != null ? [] : [
      "cloudbuild.googleapis.com",
      "compute.googleapis.com",
      "container.googleapis.com",
    ]
  )
  logging_data_access = {
    "iam.googleapis.com" = {
      ADMIN_READ = []
    }
  }
  log_bucket_name                  = "iac-core-0-bkt-logs"
  bucket_name                      = "iac-core-0-state"
  service_account_email            = module.automation-tf-resman-sa.iam_email
  internal_service_account_email   = module.automation-tf-bootstrap-sa.iam_email
  kms_key_name                     = "iac-core-0-kms-key"
}

# output files bucket

module "automation-tf-output-gcs" {
  source        = "../../../modules/gcs"
  project_id    = module.automation-project.project_id
  name          = "iac-core-outputs-0"
  prefix        = local.prefix
  location      = local.locations.gcs
  storage_class = local.gcs_storage_class
  versioning    = true
  depends_on    = [module.organization]
}

# this stage's bucket and service account

module "automation-tf-bootstrap-gcs" {
  source        = "../../../modules/gcs"
  project_id    = module.automation-project.project_id
  name          = "iac-core-bootstrap-0"
  prefix        = local.prefix
  location      = local.locations.gcs
  storage_class = local.gcs_storage_class
  versioning    = true
  depends_on    = [module.organization]
}

module "automation-tf-bootstrap-sa" {
  source       = "../../../modules/iam-service-account"
  project_id   = module.automation-project.project_id
  name         = "bootstrap-0"
  display_name = "Service account for bootstrap-0, bootstrap service account."
  prefix       = local.prefix
  # allow SA used by CI/CD workflow to impersonate this SA
  iam = {
    "roles/iam.serviceAccountTokenCreator" = compact([
      try(module.automation-tf-cicd-sa["bootstrap"].iam_email, null)
    ])
  }
  iam_storage_roles = {
    (module.automation-tf-output-gcs.name) = ["roles/storage.admin"]
  }
}

module "automation-tf-bootstrap-r-sa" {
  source       = "../../../modules/iam-service-account"
  project_id   = module.automation-project.project_id
  name         = "bootstrap-0r"
  display_name = "Service account for bootstrap-0r use for workflow (read-only)."
  prefix       = local.prefix
  # allow SA used by CI/CD workflow to impersonate this SA
  iam = {
    "roles/iam.serviceAccountTokenCreator" = compact([
      try(module.automation-tf-cicd-r-sa["bootstrap"].iam_email, null)
    ])
  }
  # we grant organization roles here as IAM bindings have precedence over
  # custom roles in the organization module, so these need to depend on it
  iam_organization_roles = {
    (var.organization.id) = [
      module.organization.custom_role_id["organization_admin_viewer"],
      module.organization.custom_role_id["tag_viewer"]
    ]
  }
  iam_storage_roles = {
    (module.automation-tf-output-gcs.name) = [module.organization.custom_role_id["storage_viewer"]]
  }
}

# resource hierarchy stage's bucket and service account

module "automation-tf-resman-gcs" {
  source        = "../../../modules/gcs"
  project_id    = module.automation-project.project_id
  name          = "iac-core-resman-0"
  prefix        = local.prefix
  location      = local.locations.gcs
  storage_class = local.gcs_storage_class
  versioning    = true
  iam = {
    "roles/storage.objectAdmin"  = [module.automation-tf-resman-sa.iam_email]
    "roles/storage.objectViewer" = [module.automation-tf-resman-r-sa.iam_email]
  }
  depends_on = [module.organization]
}

module "automation-tf-resman-sa" {
  source       = "../../../modules/iam-service-account"
  project_id   = module.automation-project.project_id
  name         = "resman-0"
  display_name = "Service account stage 1 resman service account."
  prefix       = local.prefix
  # allow SA used by CI/CD workflow to impersonate this SA
  # we use additive IAM to allow tenant CI/CD SAs to impersonate it
  iam_bindings_additive = (
    local.cicd_resman_sa == "" ? {} : {
      cicd_token_creator = {
        member = local.cicd_resman_sa
        role   = "roles/iam.serviceAccountTokenCreator"
      }
    }
  )
  iam_storage_roles = {
    (module.automation-tf-output-gcs.name) = ["roles/storage.admin"]
  }
}

module "automation-tf-resman-r-sa" {
  source       = "../../../modules/iam-service-account"
  project_id   = module.automation-project.project_id
  name         = "resman-0r"
  display_name = "Service account stage 1 resman service account (read-only)."
  prefix       = local.prefix
  # allow SA used by CI/CD workflow to impersonate this SA
  # we use additive IAM to allow tenant CI/CD SAs to impersonate it
  iam_bindings_additive = (
    local.cicd_resman_r_sa == "" ? {} : {
      cicd_token_creator = {
        member = local.cicd_resman_r_sa
        role   = "roles/iam.serviceAccountTokenCreator"
      }
    }
  )
  # we grant organization roles here as IAM bindings have precedence over
  # custom roles in the organization module, so these need to depend on it
  iam_organization_roles = {
    (var.organization.id) = [
      module.organization.custom_role_id["organization_admin_viewer"],
      module.organization.custom_role_id["tag_viewer"]
    ]
  }
  iam_storage_roles = {
    (module.automation-tf-output-gcs.name) = [module.organization.custom_role_id["storage_viewer"]]
  }
}

# Log bucket for storing access logs
resource "google_storage_bucket" "log_bucket" {
  name          = "${var.log_bucket_name}-${local.descriptive_name}"
  location      = var.region
  project       = module.automation-project.project_id
  storage_class = "STANDARD"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 365
    }
  }

  labels = {
    environment = "production"
    purpose     = "logging"
  }

  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "terraform_state" {
  name          = "${var.bucket_name}"      # -${local.descriptive_name}
  location      = var.region
  project       = module.automation-project.project_id
  storage_class = "STANDARD"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "NEARLINE"
    }
    condition {
      age                   = 365
      matches_storage_class = ["STANDARD", "DURABLE_REDUCED_AVAILABILITY"]
    }
  }

  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "COLDLINE"
    }
    condition {
      age                   = 1095
      matches_storage_class = ["NEARLINE"]
    }
  }

  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "ARCHIVE"
    }
    condition {
      age                   = 1825
      matches_storage_class = ["COLDLINE"]
    }
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age    = 2555
    }
  }

  uniform_bucket_level_access = true

  logging {
    log_bucket        = google_storage_bucket.log_bucket.name
    log_object_prefix = "logs/"
  }

  # encryption {
  #   default_kms_key_name = var.kms_key_name
  # }

  # retention_policy {
  #   retention_period = 365 * 3 // 3 years
  # }

  labels = {
    environment = "production"
    purpose     = "terraform-state"
  }

  depends_on = [
    google_storage_bucket.log_bucket
  ]
}

resource "google_storage_bucket_iam_binding" "no_public_access" {
  bucket = google_storage_bucket.terraform_state.name
  role   = "roles/storage.objectViewer"

  members = [
    "serviceAccount:${var.service_account_email}"
  ]

  condition {
    title       = "No public access"
    description = "Prevent public access"
    expression  = "request.auth != null"
  }
}

resource "google_storage_bucket_iam_member" "internal_only" {
  bucket = google_storage_bucket.terraform_state.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${var.service_account_email}"
}

