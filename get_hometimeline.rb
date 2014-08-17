require './base'

class GetPopTw
  class << self
  	include Base
    def get_tweets(screen_name: '')
      response = @endpoint.request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=#{screen_name}")
      tw_select(response)
    end
  end
end

