require "yaml"
require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

before do
  @users = YAML.load_file("users.yaml")
end

helpers do
  def total_users
    @users.keys.count
  end

  def count_interests
    @users.inject(0) do |sum, (user, info)|
      sum += info[:interests].count
    end
  end
end

get "/" do
  redirect "/users"
end

get "/users" do
  erb :user_list
end

get "/:user_name" do
  @user_name = params[:user_name].to_sym
  @email = @users[@user_name][:email]
  @interests = @users[@user_name][:interests].join(", ")

  erb :current_user
end
