# require 'httparty'
enable :sessions

CALLBACK_URL = "http://localhost:9393/oauth/callback"

Instagram.configure do |config|
  config.client_id = '2c3d8f2235aa415e942b7859632002b4'
  config.client_secret = 'fd9ca2da3eb4411f92ae6494ac37c1da'
end


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

get "/oauth/connect" do
  redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
end

get "/oauth/callback" do
  response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
  session[:access_token] = response.access_token
  redirect "/"
end

get "/logout" do
  session[:access_token] = nil
  redirect '/'
end
