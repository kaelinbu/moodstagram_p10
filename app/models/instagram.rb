module Instagram
  class Client
    include HTTParty
    base_uri 'https://api.instagram.com'

    def get_images(keyword)
      response = self.class.get("/v1/tags/#{keyword}/media/recent?client_id="+ENV['INSTAGRAM_KEY'],
        :query => {}
        )
      checkAndCreateImages(response,keyword)
    end

    def checkAndCreateImages(responseHash, keyword)
      if Image.find_by_url(responseHash[:url]) == nil
       responseHash["data"].map {|post| Image.create(tag: keyword, url: post["images"]["standard_resolution"]["url"])}
     end
    end
  end
end

