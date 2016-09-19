require 'twitter'

class TwitterHelper

  def self.twitter_client
    # normally you would generate your bearer token
    Twitter::REST::Client.new do |config|
      config.bearer_token = "XXX"
    end
  end

  def self.twitter_user_info
    $twitter_user_info ||= []
  end

  def self.twitter_error
    $twitter_error ||= nil
  end

  def self.tweets
      twitter_handle = "loadtocode"
      twitter_user_info[1] = twitter_client.user(twitter_handle).name
      twitter_user_info[2] = twitter_client.user_timeline(twitter_handle).select{ |tweet| tweet.text.start_with?('RT','@')==false}.take(3)

      twitter_user_info
    rescue Twitter::Error::BadRequest
      $twitter_error = "Oh no! no. no. no."
    rescue Twitter::Error::Unauthorized
      puts "Tweets can't be shown"
      $twitter_error = "Oh no!"
    rescue Twitter::Error::Forbidden
    rescue Twitter::Error::NotAcceptable
    rescue Twitter::Error::TooManyRequests
  end
end

# TwitterHelper.new
# puts TwitterHelper.tweets
