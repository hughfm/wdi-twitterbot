require 'rubygems'
require 'bundler/setup'

require 'twitter'

config_options = {
  consumer_key: ENV['TWITTER_CONSUMER_KEY'],
  consumer_secret: ENV['TWITTER_CONSUMER_SECRET'],
  access_token: ENV['TWITTER_ACCESS_TOKEN'],
  access_token_secret: ENV['TWITTER_ACCESS_TOKEN_SECRET']
}


class TwitterREST
  attr_reader :client

  def initialize(client)
    @client = client
  end

  def user_id
    @client.user.id
  end

  def reply_to(tweet, recipient_name, message)
    @client.update("@#{recipient_name} #{message}", {
        in_reply_to_status: tweet
      })
  end
end

class ParseTweet
  def self.extract_bangs_from(tweet)
    tweet.full_text.scan(/(?:^|\s)!(\w+)\b/).flatten
  end
end

streaming_client = Twitter::Streaming::Client.new(config_options)
twitter_rest = TwitterREST.new(Twitter::REST::Client.new(config_options))

streaming_client.user do |object|
  case object
  when Twitter::Tweet
    unless object.user.id == twitter_rest.user_id
      user = object.user
      twitter_rest.reply_to(object, user.screen_name, "thanks for the tweet.")
      print ParseTweet.extract_bangs_from(object)
    end
  end
end
