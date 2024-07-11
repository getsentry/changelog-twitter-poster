resource "google_secret_manager_secret" "secret" {
  for_each  = { for s in local.secrets : s => s }
  secret_id = each.value
  replication {
    auto {}
  }
}

locals {
  secrets = [
    "getsentry_twitter_consumer_key",
    "getsentry_twitter_consumer_secret",
    "getsentry_twitter_access_token",
    "getsentry_twitter_access_token_secret",
  ]
}