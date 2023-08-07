require "yaml"

require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'
require 'pry'

before do
  @users = YAML.load_file("users.yaml")
end

helpers do
  def count_interests
    @users.values.map { |user| user[:interests] }.flatten.uniq.size
  end
end

get "/" do
  redirect "/users"
end

get "/users" do
  erb :users
end

get "/:name" do
  @name = params[:name].to_sym
  @email = @users[@name][:email]
  @interests = @users[@name][:interests]

  erb :user
end
