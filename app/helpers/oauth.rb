require 'oauth/consumer'

def oauth_consumer
  raise RuntimeError, "You must set INSTAGRAM_KEY and INSTAGRAM_SECRET in your server environment." unless ENV['INSTAGRAM_KEY'] and ENV['INSTAGRAM_SECRET']
  @consumer ||= OAuth::Consumer.new(
    ENV['INSTAGRAM_KEY'],
    ENV['INSTAGRAM_SECRET'],
    :site => "https://api.instagram.com"
  )
end

def request_token
  if not session[:request_token]
    # this 'host_and_port' logic allows our app to work both locally and on Heroku
    host_and_port = request.host
    host_and_port << ":9393" if request.host == "localhost"

    # the `oauth_consumer` method is defined above
    session[:request_token] = oauth_consumer.get_request_token(
      :oauth_callback => "http://#{host_and_port}/auth"
    )
  end
  session[:request_token]
end
