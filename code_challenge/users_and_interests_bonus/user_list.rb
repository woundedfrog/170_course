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

get "/interests" do
  erb :interests
end

get "/:keyword_name" do
  if @users.map { |names,_| names }.include?(params[:keyword_name].to_sym)
    @user_name = params[:keyword_name].to_sym
    @email = @users[@user_name][:email]
    @interests = @users[@user_name][:interests]

    erb :current_user
  else
    erb :keyword_search
  end
end
