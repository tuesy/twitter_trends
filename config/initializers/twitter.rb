$twitter = Twitter::REST::Client.new do |config|
  config.consumer_key    = ENV['TWITTER_TRENDS_KEY']
  config.consumer_secret = ENV['TWITTER_TRENDS_SECRET']
end
