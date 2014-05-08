require 'httparty'

get '/' do
  @choices = {happy: "HAPPY",
              friends: "FRIENDLY",
              peaceful: "PEACEFUL",
              grateful: "GRATEFUL",
              selfie: "SELF CENTERED",
              love: "LOVEY"}
  erb :index
end

get '/images' do
  @keyword = params[:tag]
  @images = Image.where(tag: @keyword).shuffle.first(20)
  @images.map! {|image| image.url}
  if @images.empty?
    client = Instagram::Client.new
    @images = client.get_images(@keyword)
    @images = Image.where(tag: @keyword).map {|image| image.url}
  end

  erb :_images, layout: false
end

