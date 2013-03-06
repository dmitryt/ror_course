require 'data_mapper'
require 'dm-sqlite-adapter'
require 'rubygems'
require 'sinatra'
require 'date'
require 'json'

require File.expand_path(File.dirname(__FILE__))+'/models'

DataMapper.setup(:default, "sqlite:///#{Dir.pwd}/project.db")

enable :sessions

before do
  unless (['/auth', '/help'].include?(request.path) || session[:user])
  	return redirect '/auth'
  end
end

get '/' do
	"It's main page"
end

get '/disk' do
	{:disk => %x(df -H).split("\n")}.to_json
end

get '/memory/:id?' do
	result = {:memory => %x(free -m).split("\n")}
	id = params[:id]
	return result.to_json unless id
	if (0...result[:memory].size) === id.to_i
		result[:memory] = result[:memory][id.to_i]
	else
		result = {:memory => nil, :error => "Invalid URL"}
	end
	result.to_json
end

get '/help' do
	erb :help
end

get '/auth' do
	erb :login
end

get '/logs' do
	erb :logs, :locals => {:logs => Log.all}
end

get '/logout' do
	session.clear
	redirect '/login'
end

post '/auth' do
	if(params[:username] != 'admin' || params[:password] != 'password')
		return redirect '/auth'
	end
	session[:user] = params[:username]
	Log.create({:ip => request.ip, :datetime => DateTime.now})
	redirect '/'
end