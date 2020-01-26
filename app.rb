require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/content_for'
require 'httparty'

CLIENT_ID = 'client'
CLIENT_SECRET = 'secret'
# Dev
AUTH_SERVER = 'http://app.dev-vcita.me:7200'
# Integration
# AUTH_SERVER = 'http:#app.meet2know.com'
# Production
# AUTH_SERVER = 'http:#app.vcita.com'
AUTHORIZE_URI = '/app/oauth/authorize'

# Define api server URLs (Core in dev, API Gateway in int, prod)
# Dev
API_SERVER = 'http://localhost:7100'
# Integration
# API_SERVER = 'https:#api-int.vchost.co/'
# Production
# API_SERVER = 'http:#api.vcita.biz'
TOKEN_URI = '/oauth/token'
CLIENTS_RETRIEVE_URI = '/platform/v1/clients'
USER_INFO_URI = '/oauth/userinfo'

get '/' do
  callback_url = "#{request.scheme}://#{request.host}:#{request.port}/callback"
  url = "#{AUTH_SERVER}#{AUTHORIZE_URI}?response_type=code&client_id=#{CLIENT_ID}&redirect_uri=#{callback_url}"
  redirect url
end

get '/callback' do
  callback_url = "#{request.scheme}://#{request.host}:#{request.port}/callback"

  response = HTTParty.post("#{API_SERVER}#{TOKEN_URI}",
    body: {
      grant_type: 'authorization_code',
      code: params["code"],
      client_id: CLIENT_ID,
      client_secret: CLIENT_SECRET,
      redirect_uri: callback_url
    }
  )

  erb :index, :locals => {:access_token => response["access_token"]}
end

get '/clients' do
  token = params["token"]
  response = HTTParty.get("#{API_SERVER}/#{CLIENTS_RETRIEVE_URI}",
    headers: {
      Authorization: "Bearer #{token}"
    }
  )

  erb :clients, :locals => {:access_token => params["token"], :clients => response["data"]["clients"]}
end

get '/user_info' do
  token = params["token"]
  response = HTTParty.get("#{API_SERVER}/#{USER_INFO_URI}",
    headers: {
      Authorization: "Bearer #{token}"
    }
  )

 erb :user_info, :locals => {:access_token => params["token"], :info => JSON.parse(response.body)}
end

not_found do
  erb 'This page does not exist'
end
