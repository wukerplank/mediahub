Sidekiq.configure_server do |config|
  config.redis = { namespace: 'mediahub_sidekiq' }

  # config.error_handlers << Proc.new { |ex,context| Airbrake.notify_or_ignore(ex, parameters: context) }
end

Sidekiq.configure_client do |config|
  config.redis = { namespace: 'mediahub_sidekiq' }
end
