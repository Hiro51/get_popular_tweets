require './base'

class GetPopTwList
  class << self
  	include Base
    def get_tweets(slug_name: '', screen_name: '')
      response = @endpoint.request(:get, "https://api.twitter.com/1.1/lists/statuses.json?slug=#{slug_name}&owner_screen_name=#{screen_name}")
      tw_select(response)
    end
  end
end


