require 'json'
require 'oauth'

def setup(consumer_key, consumer_secret, access_token, access_token_secret)
	consumer = OAuth::Consumer.new(
	  consumer_key, 
	  consumer_secret, 
	  site:'https://api.twitter.com/'
	)
	endpoint = OAuth::AccessToken.new(consumer, access_token, access_token_secret)
end

def show_tweets(screen_name) 
	response = endpoint.request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=#{screen_name}")
	result = JSON.parse(response.body)
	result.map { |ary| [ary["user"]["screen_name"],ary["text"], ary["favorite_count"],ary["retweet_count"]] }
end