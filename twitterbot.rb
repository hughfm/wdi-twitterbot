require 'rubygems'
require 'bundler/setup'

require_relative 'wdi-api'
require_relative 'twitterbot-tweets'
require_relative 'twitter-api'

config_options = {
  consumer_key: ENV['TWITTER_CONSUMER_KEY'],
  consumer_secret: ENV['TWITTER_CONSUMER_SECRET'],
  access_token: ENV['TWITTER_ACCESS_TOKEN'],
  access_token_secret: ENV['TWITTER_ACCESS_TOKEN_SECRET']
}

twitter_stream = TwitterStream.new(config_options)
twitter_rest = TwitterREST.new(config_options)

twitter_stream.client.user do |object|
  case object
  when Twitter::Tweet
    user = object.user
    bangs = ParseTweet.extract_bangs_from(object) unless twitter_rest.is_me? user
    ParseTweet.log(object, bangs)
    next if twitter_rest.is_me? user
    if bangs.include? "?"
      twitter_rest.reply_to(object, user.screen_name, TweetConstructor.help)
    elsif bangs.include? "i"
      twitter_rest.reply_to(object, user.screen_name, TweetConstructor.info(WdiAPI.get_info))
    elsif bangs.include? "$"
      twitter_rest.reply_to(object, user.screen_name, TweetConstructor.reserve)
    elsif bangs.include? "s"
      twitter_rest.reply_to(object, user.screen_name, TweetConstructor.talks(WdiAPI.get_talks))
    elsif bangs.include? "m"
      twitter_rest.reply_to(object, user.screen_name, TweetConstructor.map_link)
    elsif bangs.include? "+"
      twitter_rest.reply_to(object, user.screen_name, TweetConstructor.more_commands)      
    else
      twitter_rest.reply_to(object, user.screen_name, TweetConstructor.welcome)
    end
  end
end
