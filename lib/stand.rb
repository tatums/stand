class Stand
  require './lib/user.rb'
  require './lib/mail.rb'
  require './lib/persist.rb'
  require 'yaml'
  require 'redis'
  require 'json'

  attr_reader :current, :on_deck
  attr_accessor :users

  CONFIG = YAML.load_file('./config/config.yml')

  def initialize
    @users = []
    load_users #load all users
    self.next #advance once to setup on deck
  end

  def next
    set_current @on_deck
    set_on_deck @users.delete(@users.sample)
  end

  def load_users
    Persist.new.smembers.each do |u|
      @users << User.new(u)
    end
  end

  private

  def set_current(user)
    @current = user || NullUser.new
  end

  def set_on_deck(user)
    @on_deck = user || NullUser.new
  end

end

class NullUser
  def first
    ""
  end
  def last; end
  def mail; end
end
