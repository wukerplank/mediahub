MediaMasterClient::Base.configure do |config|
  config.app_uid = ENV['MEDIA_MASTER_CLIENT_APP_UID']
  config.app_secret = ENV['MEDIA_MASTER_CLIENT_APP_SECRET']
  config.host = ENV['MEDIA_MASTER_CLIENT_HOST']
end
