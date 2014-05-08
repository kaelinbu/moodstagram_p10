module Instagram
  class Client
    include HTTParty
    base_uri 'https://api.instagram.com'

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