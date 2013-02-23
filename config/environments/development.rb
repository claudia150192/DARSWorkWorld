EsiVcu::Application.configure do
#  config.logger = Logger.new(STDOUT)
  config.action_mailer.delivery_method = :file
  config.cache_classes = false
  config.active_support.deprecation = :log
end
