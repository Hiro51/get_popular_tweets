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

def show_tweets(slug_name, screen_name)
	response = endpoint.request(:get, "https://api.twitter.com/1.1/lists/statuses.json?slug=#{slug_name}&owner_screen_name=#{screen_name}")
	result = JSON.parse(response.body)
	tweet = result.map { |ary| [ary["user"]["screen_name"], ary["text"], ary["favorite_count"],ary["retweet_count"]] }
	chosen_tweet = tweet.select { |item| item[2] > 5 || item[3] >10 }
	puts chosen_tweet
end
