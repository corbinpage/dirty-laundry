Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, ENV['SKETCH_METER_CONSUMER_KEY'], ENV['SKETCH_METER_CONSUMER_SECRET']
end