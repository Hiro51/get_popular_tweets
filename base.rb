require 'json'
require 'oauth'

module Base
  ENDPOINT = 'https://api.twitter.com/'

   def setup(consumer_key: '', consumer_secret: '', access_token: '', access_token_secret: '')
    @endpoint = OAuth::AccessToken.new(
    consumer(consumer_key, consumer_secret),
    access_token,
    access_token_secret
    )
  end

  def set_opt(favorite_count: 5, retweet_count: 10, is_logical_and: true )
    @opt = {}
    @opt[:favorite_count] = favorite_count
    @opt[:retweet_count] = retweet_count
    @opt[:is_logical_and] = is_logical_and
  end

  private def consumer(consumer_key, consumer_secret)
    OAuth::Consumer.new(
      consumer_key, 
      consumer_secret, 
      site: ENDPOINT
    )
  end

 private def tw_select(response)
    tweets = JSON.parse(response.body).map do |result| 
      {
        screen_name: result["user"]["screen_name"],
        contents: result["text"],
        favorite_count: result["favorite_count"],
        retweet_count: result["retweet_count"]
      }
    end
  	tweets.select do |tweet| 
      is_more_fav = tweet[:favorite_count] > @opt[:favorite_count]
      is_more_rt = tweet[:retweet_count] > @opt[:retweet_count]
      @opt[:is_logical_and] ? is_more_fav && is_more_rt : is_more_fav || is_more_rt
    end
  end
end