require 'twitter'

class TwitterREST
  attr_reader :client, :user, :id

  def initialize(config_options)
    @client = Twitter::REST::Client.new(config_options)
    @user = @client.user
    @id = @user.id
  end

  def reply_to(tweet, recipient_name, message)
    available_chars = 140 - 1 - recipient_name.length - 1
    number_of_tweets = (message.length.to_f / available_chars.to_f).ceil
    chunk_start = 0
    puts message
    puts available_chars
    puts number_of_tweets
    number_of_tweets.times do
      chunk = message.slice(chunk_start, available_chars)
      tweet = @client.update("@#{recipient_name} #{chunk}", {
          in_reply_to_status: tweet
      })
      chunk_start += available_chars
    end
  end

  def is_me?(user)
    @id == user.id
  end
end

class TwitterStream
  attr_reader :client

  def initialize(config_options)
    @client = Twitter::Streaming::Client.new(config_options)
  end
end

class ParseTweet
  def self.extract_bangs_from(tweet)
    tweet.full_text.scan(/(?:^|\s)!([ism\?\$\+])/).flatten
  end

  def self.log(tweet, bangs = [])
    puts "Tweet from @#{tweet.user.screen_name}: #{tweet.full_text}"
    puts "!BANGS: #{bangs}"
    puts "----------------------------------------"
  end
end
