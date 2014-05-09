module Instagram
  class Client
    include HTTParty
    base_uri 'https://api.instagram.com'

    # def initialize(auth)
    #   @instagram_rest_client = INTSTAGRAM::REST::Client.new do |config|
    #     config.consumer_key = ENV['INSTAGRAM_KEY']
    #     config.consumer_secret = ENV['INSTAGRAM_SECRET']
    #     config.oauth_token = auth[:token]
    #     config.oauth_token_secret = auth[:secret]
    #   end
    # end

    def post_collage(image)
      # @twitter_rest_client.update("#{tweet}")
    end

    def get_username
      # @instagram_rest_client.user.screen_name
    end

    def get_images(keyword)
      response = self.class.get("/v1/tags/#{keyword}/media/recent?client_id="+ENV['INSTAGRAM_KEY'],
        :query => {}
        )
      create_images(response,keyword)
    end

    def create_images(responseHash, keyword)
      responseHash["data"].map do |post|
        if check_url_uniqueness(post)
          Image.create(tag: keyword, url: post["images"]["standard_resolution"]["url"])
        end
      end
    end

    def check_url_uniqueness(post)
      return true if Image.find_by_url(post["images"]["standard_resolution"]["url"]) == nil
    end
  end
end