require 'httparty'

get '/' do
  erb :index
end

get '/images' do
  @keyword = params[:tag]
  @images = Image.where(tag: @keyword).map {|image| image.url}
  if @images.empty?
    client = Instagram::Client.new
    @images = client.get_images(@keyword)
    @images = Image.where(tag: @keyword).map {|image| image.url}
  end

  erb :_images, layout: false
end

