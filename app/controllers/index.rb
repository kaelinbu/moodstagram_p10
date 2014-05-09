require 'httparty'

get '/' do
  @choices = ChoiceRetriever.return_choices
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

get '/update' do
  @choices = ChoiceRetriever.return_choices
  erb :_buttons, layout: false
end

get '/sign_in' do
  redirect request_token.authorize_url
end

get 'auth' do
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])

  session.delete(:request_token)

  auth = { token: @access_token.token, secret: @access_token.secret}
    api_client = Instagram::Client.new(auth)
    username = api_client.get_username
    users = User.all
    found = false

    users.each do |user|
      found = true if user.username == username
    end

    if found
      user = User.find_by_username(username)
    else
      args = { oauth_token: @access_token.token, oauth_secret: @access_token.secret, username: username }
      user = User.create(args)
    end
  session.delete(:user_id)
  session[:user_id] = user.id
  redirect "/"
end