module Instagram
  class Client
    include HTTParty
    base_uri 'https://api.instagram.com'

    def get_images(keyword)
      response = self.class.get("/v1/tags/#{keyword}/media/recent?client_id="+ENV['INSTAGRAM_KEY'],
        :query => {count:30,
                    max_id: 1399377631050085}
                    # max_id = ["pagination"]["next_max_tag_id"]- can interate through a given number of times to get multiple pages
        )
      parseForImages(response, keyword)
    end

    def parseForImages(responseHash, keyword)
      return responseHash["data"].map {|post| Image.create(tag: keyword, url: post["images"]["standard_resolution"]["url"])}
    end
  end
end

