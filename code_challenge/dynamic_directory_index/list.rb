require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @files = Dir.glob("public/*").map { |file| File.basename(file) }.sort
  @files.reverse! if params[:sort] == "desc"
  erb :list
end

get "/fonts" do
  @sub_files = Dir.glob("public/fonts/*").map { |file| File.basename(file) }.sort
  @sub_files.reverse! if params[:sort] == "desc"
  erb :sub_list
end
