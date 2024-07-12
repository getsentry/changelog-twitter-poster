module "changelog-twitter-poster" {
  source = "../modules/cloud-function-gen2"
  name                = "changelog-twitter-poster"
  description         = "Posting updates from https://sentry.io/changelog/ to the Sentry Changelog Twitter account"
  source_dir          = "changelog-twitter-poster"
  execution_timeout   = 120
  available_memory_mb = "128Mi"
  
  secret_environment_variables = [
    {
      key     = "sentrychangelog_twitter_consumer_key"
      secret  = google_secret_manager_secret.secret["sentrychangelog_twitter_consumer_key"].secret_id
      version = "latest"
    },
    {
      key     = "sentrychangelog_twitter_consumer_secret"
      secret  = google_secret_manager_secret.secret["sentrychangelog_twitter_consumer_secret"].secret_id
      version = "latest"
    },
    {
      key     = "sentrychangelog_twitter_access_token"
      secret  = google_secret_manager_secret.secret["sentrychangelog_twitter_access_token"].secret_id
      version = "latest"
    },
    {
      key     = "sentrychangelog_twitter_access_token_secret"
      secret  = google_secret_manager_secret.secret["sentrychangelog_twitter_access_token_secret"].secret_id
      version = "latest"
    },
    {
      key     = "sentrychangelog_webhook_auth_header"
      secret  = google_secret_manager_secret.secret["sentrychangelog_webhook_auth_header"].secret_id
      version = "latest"
    },
  ]
}