require 'rubygems'
require 'sinatra'
require 'rack-flash'
require 'haml'
require 'pry'

require './lib/stand.rb'


enable :sessions
use Rack::Flash

before do
  session[:stand] ||= Stand.new
  @stand = session[:stand]
end

get '/' do
  @user = @stand.current
  @on_deck = @stand.on_deck
  haml :index
end

get '/next' do
  session[:stand].next
  redirect to('/')
end

post '/reset' do
  session[:stand] = nil
  flash[:notice] = "Reset successfull."
  redirect to('/')
end

get '/email' do
  session[:stand].current.mail
  flash[:notice] = "Email sent" unless null_user?
  redirect to('/')
end

get '/import' do
  haml :import
end

post '/process_import' do
  @file = YAML.load_file(params[:file][:tempfile])
  Persist.new.sadd(@file)
  session[:stand]  = nil
  flash[:notice] = "The file has been processed!!"
  redirect to('/')
end

private

def null_user?
  session[:stand].current.class == NullUser
end
