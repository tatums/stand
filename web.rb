require 'rubygems'
require 'sinatra'
require 'rack-flash'
require 'haml'
require 'pry'
require './lib/stand.rb'

#set :haml
enable :sessions
use Rack::Flash

before do
  session[:stand] ||= Stand.new
  @stand = session[:stand]
end

get '/' do
  @user = @stand.current
  haml :index
end

post '/next' do
  session[:stand].next
  #flash[:notice] = "Dude! You're getting a dell." unless null_user?
  redirect to('/')
end

post '/reset' do
  session[:stand] = nil
  flash[:notice] = "Reset successfull."
  redirect to('/')
end

post '/email' do
  session[:stand].current.mail
  flash[:notice] = "Email sent" unless null_user?
  redirect to('/')
end

get '/import' do
  haml :import
end

post '/process_import' do
  @stand.load_users YAML.load_file(params[:file][:tempfile])
  flash[:notice] = "The file has been processed!!"
  redirect to('/')
end

private

def null_user?
  session[:stand].current.class == NullUser
end
