# WDI Conf Twitter Bot

This project was part of the Web Development Immersive (WDI) course at General Assembly. We held a mock conference, and built an API and website for it as a group project.

The Twitter bot grew out of the idea to provide access to all the relevant information from the conference website, all through a Twitter account.

## Usage

If the bot is currently live, you can see it in action by tweeting __@wdiconf__. If it is listening, you will get an immediate response with further instructions.

## Bang-Lang (!lang)

The bot searches tweets for certain keywords beginning with a (!) bang, and then builds the appropriate response accordingly. For example, a tweet containing !i, would trigger a response containing basic conference info like location, time, etc.

## Tools & Technologies

I used the __[Twitter](https://github.com/sferik/twitter)__ gem, which made working with the Twitter APIs significantly easier!

The bot required the use of both Twitter's __[Streaming API](https://dev.twitter.com/streaming/overview)__ (to listen for tweet events), and the __[REST API](https://dev.twitter.com/rest/public)__ (to post responses).

Tweets are parsed for !keywords using a __regular expression__. 
