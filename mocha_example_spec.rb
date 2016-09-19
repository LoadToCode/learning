require "./pacman"
require 'rubygems'
require 'twitter'
require "./twitterhelper_mock"

describe "whatevs" do
  it "the board has 16 dots" do
    fake_pacman = instance_double("Pacman")
    allow(fake_pacman).to receive(:score).and_return(20)

    allow(Pacman).to receive(:new).and_return(fake_pacman)

    my_pacman = Pacman.new
    expect(my_pacman.score).to eq 20
  end

  it "mocks the twitter client" do
    fake_client = instance_double("Twitter::REST::Client")
    fake_user = instance_double("Twitter::User")
    fake_tweet = instance_double("Twitter::Tweet")
    fake_timeline = [fake_tweet]

    expect(fake_user).to receive(:name).and_return("Thea")
    allow(fake_tweet).to receive(:text).and_return("Floop")
    expect(fake_client).to receive(:user).and_return(fake_user)
    expect(fake_client).to receive(:user_timeline).and_return(fake_timeline)

    allow(Twitter::REST::Client).to receive(:new).and_return(fake_client)

    TwitterHelper.tweets()
    expect(TwitterHelper.twitter_user_info[1]).to eq "Thea"
    expect(TwitterHelper.twitter_user_info[2][0].text).to eq "Floop"
    expect(TwitterHelper.twitter_error).to eq nil
  end

  it "mocks the twitter client" do
    fake_client = instance_double("Twitter::REST::Client")
    fake_error = Twitter::Error::Unauthorized

    expect(fake_client).to receive(:user).and_raise(error)

    allow(Twitter::REST::Client).to receive(:new).and_return(fake_client)

    TwitterHelper.tweets()
    expect(TwitterHelper.twitter_error).to eq "Oh no!"
  end

end


# require 'twitter'
#
# class TwitterHelper
#
#   def self.twitter_client
#     # normally you would generate your bearer token
#     Twitter::REST::Client.new do |config|
#       config.bearer_token = "AAAAAAAAAAAAAAAAAAAAAKwJwQAAAAAAv4nPKQt2hfiXyNOjgUu%2B2Gnr%2BgY%3DdQQuDMfGckqUJb0TfK3uZRv4fWBRf1xvSYHiih1JqYDVQ3dH0R"
#     end
#   end
#
#   def self.tweets
#       twitter_handle = "loadtocode"
#       twitter_user_info ||= []
#       twitter_user_info[1] = twitter_client.user(twitter_handle).name
#       twitter_user_info[2] = twitter_client.user_timeline(twitter_handle).select{ |tweet| tweet.text.start_with?('RT','@')==false}.take(3)
#     rescue Twitter::Error::BadRequest
#       puts "BadRequest"
#     rescue Twitter::Error::Unauthorized
#       puts "Tweets can't be shown"
#     rescue Twitter::Error::Forbidden
#     rescue Twitter::Error::NotAcceptable
#     rescue Twitter::Error::TooManyRequests
#   end
# end
#
# TwitterHelper.new
# puts TwitterHelper.tweets
