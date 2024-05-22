Copyright 2022 Google LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.29.1 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 5.29.1 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_automation-project"></a> [automation-project](#module\_automation-project) | ../../../modules/project | n/a |
| <a name="module_automation-tf-bootstrap-gcs"></a> [automation-tf-bootstrap-gcs](#module\_automation-tf-bootstrap-gcs) | ../../../modules/gcs | n/a |
| <a name="module_automation-tf-bootstrap-r-sa"></a> [automation-tf-bootstrap-r-sa](#module\_automation-tf-bootstrap-r-sa) | ../../../modules/iam-service-account | n/a |
| <a name="module_automation-tf-bootstrap-sa"></a> [automation-tf-bootstrap-sa](#module\_automation-tf-bootstrap-sa) | ../../../modules/iam-service-account | n/a |
| <a name="module_automation-tf-checklist-gcs"></a> [automation-tf-checklist-gcs](#module\_automation-tf-checklist-gcs) | ../../../modules/gcs | n/a |
| <a name="module_automation-tf-cicd-r-sa"></a> [automation-tf-cicd-r-sa](#module\_automation-tf-cicd-r-sa) | ../../../modules/iam-service-account | n/a |
| <a name="module_automation-tf-cicd-repo"></a> [automation-tf-cicd-repo](#module\_automation-tf-cicd-repo) | ../../../modules/source-repository | n/a |
| <a name="module_automation-tf-cicd-sa"></a> [automation-tf-cicd-sa](#module\_automation-tf-cicd-sa) | ../../../modules/iam-service-account | n/a |
| <a name="module_automation-tf-output-gcs"></a> [automation-tf-output-gcs](#module\_automation-tf-output-gcs) | ../../../modules/gcs | n/a |
| <a name="module_automation-tf-resman-gcs"></a> [automation-tf-resman-gcs](#module\_automation-tf-resman-gcs) | ../../../modules/gcs | n/a |
| <a name="module_automation-tf-resman-r-sa"></a> [automation-tf-resman-r-sa](#module\_automation-tf-resman-r-sa) | ../../../modules/iam-service-account | n/a |
| <a name="module_automation-tf-resman-sa"></a> [automation-tf-resman-sa](#module\_automation-tf-resman-sa) | ../../../modules/iam-service-account | n/a |
| <a name="module_billing-export-dataset"></a> [billing-export-dataset](#module\_billing-export-dataset) | ../../../modules/bigquery-dataset | n/a |
| <a name="module_billing-export-project"></a> [billing-export-project](#module\_billing-export-project) | ../../../modules/project | n/a |
| <a name="module_log-export-dataset"></a> [log-export-dataset](#module\_log-export-dataset) | ../../../modules/bigquery-dataset | n/a |
| <a name="module_log-export-gcs"></a> [log-export-gcs](#module\_log-export-gcs) | ../../../modules/gcs | n/a |
| <a name="module_log-export-logbucket"></a> [log-export-logbucket](#module\_log-export-logbucket) | ../../../modules/logging-bucket | n/a |
| <a name="module_log-export-project"></a> [log-export-project](#module\_log-export-project) | ../../../modules/project | n/a |
| <a name="module_log-export-pubsub"></a> [log-export-pubsub](#module\_log-export-pubsub) | ../../../modules/pubsub | n/a |
| <a name="module_organization"></a> [organization](#module\_organization) | ../../../modules/organization | n/a |
| <a name="module_organization-logging"></a> [organization-logging](#module\_organization-logging) | ../../../modules/organization | n/a |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_iam_workload_identity_pool.default](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_iam_workload_identity_pool) | resource |
| [google-beta_google_iam_workload_identity_pool_provider.default](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_iam_workload_identity_pool_provider) | resource |
| [google_billing_account_iam_member.billing_ext_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/billing_account_iam_member) | resource |
| [google_billing_account_iam_member.billing_ext_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/billing_account_iam_member) | resource |
| [google_iam_workforce_pool.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workforce_pool) | resource |
| [google_iam_workforce_pool_provider.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workforce_pool_provider) | resource |
| [google_storage_bucket_object.checklist_data](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [google_storage_bucket_object.checklist_org_iam](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [google_storage_bucket_object.providers](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [google_storage_bucket_object.tfvars](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [google_storage_bucket_object.tfvars_globals](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [google_storage_bucket_object.workflows](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [local_file.providers](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.tfvars](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.tfvars_globals](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.workflows](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | Billing account id. If billing account is not part of the same org set `is_org_level` to `false`. To disable handling of billing IAM roles set `no_iam` to `true`. | <pre>object({<br>    id           = string<br>    is_org_level = optional(bool, true)<br>    no_iam       = optional(bool, false)<br>  })</pre> | n/a | yes |
| <a name="input_bootstrap_user"></a> [bootstrap\_user](#input\_bootstrap\_user) | Email of the nominal user running this stage for the first time. | `string` | `null` | no |
| <a name="input_cicd_repositories"></a> [cicd\_repositories](#input\_cicd\_repositories) | CI/CD repository configuration. Identity providers reference keys in the `federated_identity_providers` variable. Set to null to disable, or set individual repositories to null if not needed. | <pre>object({<br>    bootstrap = optional(object({<br>      name              = string<br>      type              = string<br>      branch            = optional(string)<br>      identity_provider = optional(string)<br>    }))<br>    resman = optional(object({<br>      name              = string<br>      type              = string<br>      branch            = optional(string)<br>      identity_provider = optional(string)<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_custom_roles"></a> [custom\_roles](#input\_custom\_roles) | Map of role names => list of permissions to additionally create at the organization level. | `map(list(string))` | `{}` | no |
| <a name="input_essential_contacts"></a> [essential\_contacts](#input\_essential\_contacts) | Email used for essential contacts, unset if null. | `string` | `null` | no |
| <a name="input_factories_config"></a> [factories\_config](#input\_factories\_config) | Configuration for the resource factories or external data. | <pre>object({<br>    checklist_data    = optional(string)<br>    checklist_org_iam = optional(string)<br>    custom_roles      = optional(string, "data/custom-roles")<br>    org_policy        = optional(string, "data/org-policies")<br>  })</pre> | `{}` | no |
| <a name="input_fast_features"></a> [fast\_features](#input\_fast\_features) | Selective control for top-level FAST features. | <pre>object({<br>    data_platform   = optional(bool, false)<br>    gcve            = optional(bool, false)<br>    gke             = optional(bool, false)<br>    project_factory = optional(bool, false)<br>    sandbox         = optional(bool, false)<br>    teams           = optional(bool, false)<br>  })</pre> | `{}` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | Group names or IAM-format principals to grant organization-level permissions. If just the name is provided, the 'group:' principal and organization domain are interpolated. | <pre>object({<br>    gcp-billing-admins      = optional(string, "gcp-billing-admins")<br>    gcp-devops              = optional(string, "gcp-devops")<br>    gcp-network-admins      = optional(string, "gcp-vpc-network-admins")<br>    gcp-organization-admins = optional(string, "gcp-organization-admins")<br>    gcp-security-admins     = optional(string, "gcp-security-admins")<br>    # aliased to gcp-devops as the checklist does not create it<br>    gcp-support = optional(string, "gcp-devops")<br>  })</pre> | `{}` | no |
| <a name="input_iam"></a> [iam](#input\_iam) | Organization-level custom IAM settings in role => [principal] format. | `map(list(string))` | `{}` | no |
| <a name="input_iam_bindings_additive"></a> [iam\_bindings\_additive](#input\_iam\_bindings\_additive) | Organization-level custom additive IAM bindings. Keys are arbitrary. | <pre>map(object({<br>    member = string<br>    role   = string<br>    condition = optional(object({<br>      expression  = string<br>      title       = string<br>      description = optional(string)<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_iam_by_principals"></a> [iam\_by\_principals](#input\_iam\_by\_principals) | Authoritative IAM binding in {PRINCIPAL => [ROLES]} format. Principals need to be statically defined to avoid cycle errors. Merged internally with the `iam` variable. | `map(list(string))` | `{}` | no |
| <a name="input_locations"></a> [locations](#input\_locations) | Optional locations for GCS, BigQuery, and logging buckets created here. | <pre>object({<br>    bq      = optional(string, "us-central1")<br>    gcs     = optional(string, "us-central1")<br>    logging = optional(string, "us-central1")<br>    pubsub  = optional(list(string), ["us-central1"])<br>  })</pre> | `{}` | no |
| <a name="input_log_sinks"></a> [log\_sinks](#input\_log\_sinks) | Org-level log sinks, in name => {type, filter} format. | <pre>map(object({<br>    filter = string<br>    type   = string<br>  }))</pre> | <pre>{<br>  "audit-logs": {<br>    "filter": "log_id(\"cloudaudit.googleapis.com/activity\") OR\nlog_id(\"cloudaudit.googleapis.com/system_event\") OR\nlog_id(\"cloudaudit.googleapis.com/policy\") OR\nlog_id(\"cloudaudit.googleapis.com/access_transparency\")\n",<br>    "type": "logging"<br>  },<br>  "iam": {<br>    "filter": "protoPayload.serviceName=\"iamcredentials.googleapis.com\" OR\nprotoPayload.serviceName=\"iam.googleapis.com\" OR\nprotoPayload.serviceName=\"sts.googleapis.com\"\n",<br>    "type": "logging"<br>  },<br>  "vpc-sc": {<br>    "filter": "protoPayload.metadata.@type=\"type.googleapis.com/google.cloud.audit.VpcServiceControlAuditMetadata\"",<br>    "type": "logging"<br>  },<br>  "workspace-audit-logs": {<br>    "filter": "logName:\"/logs/cloudaudit.googleapis.com%2Fdata_access\" and protoPayload.serviceName:\"login.googleapis.com\"",<br>    "type": "logging"<br>  }<br>}</pre> | no |
| <a name="input_org_policies_config"></a> [org\_policies\_config](#input\_org\_policies\_config) | Organization policies customization. | <pre>object({<br>    constraints = optional(object({<br>      allowed_policy_member_domains = optional(list(string), [])<br>    }), {})<br>    import_defaults = optional(bool, false)<br>    tag_name        = optional(string, "org-policies")<br>    tag_values = optional(map(object({<br>      description = optional(string, "Managed by the Terraform organization module.")<br>      iam         = optional(map(list(string)), {})<br>      id          = optional(string)<br>    })), {})<br>  })</pre> | `{}` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Organization details. | <pre>object({<br>    id          = number<br>    domain      = optional(string)<br>    customer_id = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_outputs_location"></a> [outputs\_location](#input\_outputs\_location) | Enable writing provider, tfvars and CI/CD workflow files to local filesystem. Leave null to disable. | `string` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix used for resources that need unique names. Use 9 characters or less. | `string` | n/a | yes |
| <a name="input_project_parent_ids"></a> [project\_parent\_ids](#input\_project\_parent\_ids) | Optional parents for projects created here in folders/nnnnnnn format. Null values will use the organization as parent. | <pre>object({<br>    automation = optional(string)<br>    billing    = optional(string)<br>    logging    = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_workforce_identity_providers"></a> [workforce\_identity\_providers](#input\_workforce\_identity\_providers) | Workforce Identity Federation pools. | <pre>map(object({<br>    attribute_condition = optional(string)<br>    issuer              = string<br>    display_name        = string<br>    description         = string<br>    disabled            = optional(bool, false)<br>    saml = optional(object({<br>      idp_metadata_xml = string<br>    }), null)<br>  }))</pre> | `{}` | no |
| <a name="input_workload_identity_providers"></a> [workload\_identity\_providers](#input\_workload\_identity\_providers) | Workload Identity Federation pools. The `cicd_repositories` variable references keys here. | <pre>map(object({<br>    attribute_condition = optional(string)<br>    issuer              = string<br>    custom_settings = optional(object({<br>      issuer_uri = optional(string)<br>      audiences  = optional(list(string), [])<br>      jwks_json  = optional(string)<br>    }), {})<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_automation"></a> [automation](#output\_automation) | Automation resources. |
| <a name="output_billing_dataset"></a> [billing\_dataset](#output\_billing\_dataset) | BigQuery dataset prepared for billing export. |
| <a name="output_cicd_repositories"></a> [cicd\_repositories](#output\_cicd\_repositories) | CI/CD repository configurations. |
| <a name="output_custom_roles"></a> [custom\_roles](#output\_custom\_roles) | Organization-level custom roles. |
| <a name="output_outputs_bucket"></a> [outputs\_bucket](#output\_outputs\_bucket) | GCS bucket where generated output files are stored. |
| <a name="output_project_ids"></a> [project\_ids](#output\_project\_ids) | Projects created by this stage. |
| <a name="output_providers"></a> [providers](#output\_providers) | Terraform provider files for this stage and dependent stages. |
| <a name="output_service_accounts"></a> [service\_accounts](#output\_service\_accounts) | Automation service accounts created by this stage. |
| <a name="output_tfvars"></a> [tfvars](#output\_tfvars) | Terraform variable files for the following stages. |
| <a name="output_workforce_identity_pool"></a> [workforce\_identity\_pool](#output\_workforce\_identity\_pool) | Workforce Identity Federation pool. |
| <a name="output_workload_identity_pool"></a> [workload\_identity\_pool](#output\_workload\_identity\_pool) | Workload Identity Federation pool and providers. |
