# use `gcloud beta billing accounts list`
# if you have too many accounts, check the Cloud Console :)
billing_account = {
  id = "012345-67890A-BCDEF0"     # Replace with actual billing account ID
}

# locations for GCS, BigQuery, and logging buckets created here
locations = {
  bq      = "us-central1"
  gcs     = "us-central1"
  logging = "us-central1"
  pubsub  = ["us-central1"]
}

# use `gcloud organizations list`
organization = {
  domain      = "cf.540.co"
  id          = "XXXXXXXXXXX" # Replace with actual organization ID
  customer_id = "C04kyb40c"
}

outputs_location = "~/fast-config" 

organization_id                  = "organizations/XXXXXXXXXXX"        # Replace with actual organization ID
bucket_name                      = "iac-core-0-state-iha"             #"iac-core-0-state"
internal_service_account_email   = "log-export-sa@iha-prod-audit-logs-0.iam.gserviceaccount.com"
kms_key_name                     = "iac-core-0-kms-key"
log_bucket_name                  = "iac-core-0-bkt-logs"
project_id                       = "iha-prod-iac-core-0"
service_account_email            = "iha-prod-bootstrap-0@iha-prod-iac-core-0.iam.gserviceaccount.com"   #"tf-bootstrap-0@iha-prod-iac-core-0.iam.gserviceaccount.com"

# use something unique and no longer than 9 characters
prefix = "iha"
