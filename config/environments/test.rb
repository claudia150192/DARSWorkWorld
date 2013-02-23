EsiVcu::Application.configure do
  config.action_mailer.delivery_method = :test
  config.action_mailer.raise_delivery_errors = true
  config.cache_classes = true
  config.active_support.deprecation = :stderr
end
