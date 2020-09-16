gcloud auth login
gcloud config set project PROJECT_ID
gcloud alpha monitoring policies list
gcloud alpha monitoring channels list

terraform import google_monitoring_alert_policy.name projects/PROJECT_ID/alertPolicies/POLICY_ID

terraform import google_monitoring_notification_channel.name projects/PROJECT_ID/notificationChannels/CHANNEL_ID

terraform show -no-color > state.tf
