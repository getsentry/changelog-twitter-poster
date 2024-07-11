module "changelog-twitter-poster" {
  source = "../modules/cloud-function-gen2"
  name                = "example-gen2"
  description         = "gen2 cloud function example"
  source_dir          = "."
  execution_timeout   = 120
  available_memory_mb = "128Mi"
  
  secret_environment_variables = [
    {
      key     = "getsentry_twitter_consumer_key"
      secret  = google_secret_manager_secret.secret["getsentry_twitter_consumer_key"].secret_id
      version = "latest"
    },
    {
      key     = "getsentry_twitter_consumer_secret"
      secret  = google_secret_manager_secret.secret["getsentry_twitter_consumer_secret"].secret_id
      version = "latest"
    },
    {
      key     = "getsentry_twitter_access_token"
      secret  = google_secret_manager_secret.secret["getsentry_twitter_access_token_secret"].secret_id
      version = "latest"
    },
    {
      key     = "getsentry_twitter_access_token_secret"
      secret  = google_secret_manager_secret.secret["getsentry_twitter_access_token_secret"].secret_id
      version = "latest"
    },
  ]
}