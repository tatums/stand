require 'rubygems'
require 'sinatra'
require 'rack-flash'
require 'haml'
require './stand.rb'

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
  flash[:notice] = "Dude! You're getting a dell." unless null_user?
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


private

def null_user?
  session[:stand].current.class == NullUser
end
