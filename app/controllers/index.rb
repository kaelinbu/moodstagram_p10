# require 'httparty'

get '/' do
  @choices = ChoiceRetriever.return_choices
  erb :index
end

get '/images' do
  @keyword = params[:tag]
  @images = Image.where(tag: @keyword).shuffle.first(16)
  @images.map! {|image| image.url}
  if @images.empty?
    client = Instagram::Client.new
    @images = client.get_images(@keyword)
    @images = Image.where(tag: @keyword).map {|image| image.url}
  end

  erb :_images, layout: false
end

get '/update' do
  @choices = ChoiceRetriever.return_choices
  erb :_buttons, layout: false
end