class Stand
  require './lib/user.rb'
  require './lib/mail.rb'
  require 'yaml'

  USERS = YAML.load_file('./config/users.yml')
  CONFIG = YAML.load_file('./config/config.yml')

  attr_reader :current
  attr_accessor :users, :completed

  def initialize
    @users = []
    load_users(USERS) #load all users
    @current = self.next #load one in the chamber
  end

  def next
    set_current @users.delete(@users.sample) # set a random user as current and delete form array
  end

  private

  def set_current(user)
    @current = user || NullUser.new
  end

  def load_users(users)
    users.each do |u|
      @users << User.new(u)
    end
  end
end

class NullUser
  def first
    "You are done..."
  end
  def last; end
  def mail; end
end
