class TweetConstructor
  def self.welcome
    "Hey there! Tweet me back with !? for some help..."
  end

  def self.info(object)
    "WDIConf: #{object['date']}, #{object['time']}, #{object['address']}"
  end

  def self.help
    "Tweet me with !i for details, !$ to buy tickets, !s for speakers, !m for the map or !+ for more commands"
  end

  def self.reserve
    "Thanks! Use the link to confirm your payment: https://wdiconf.com/payments"
  end

  def self.talks(object)
    tweet = ""
    object.each_with_index do |talk, i|
      tweet += "#{format_time_string(talk['starttime'])} #{abbreviate_name(talk['speaker'])}"
      tweet += ", " unless i == (object.length - 1)
    end
    tweet
  end

  def self.map_link
    "http://googlemaps.com/link"
  end

  def self.more_commands
    "Tweet: !q #talkname to ask a question or !15 #talkname to get a 15 min reminder via tweet"
  end

  def self.format_time_string(string)
    Time.parse(string).strftime("%I:%M")
  end

  def self.abbreviate_name(speaker)
    "#{speaker['firstname'][0]} #{speaker['lastname']}"
  end
end
