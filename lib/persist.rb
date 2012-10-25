class Persist
	require 'yaml'
  require 'json'

  attr_reader :key, :smembers, :redis
  def initialize
  	@redis = Redis.new(:host => Stand::CONFIG['redis']['host'], :port => Stand::CONFIG['redis']['port'])
    @key = 'users'
  end

  def sadd(data)
    destroy_set
    data.each do |datum|
      @redis.sadd(@key, datum.to_json)
    end
  end

  def smembers
    @redis.smembers(@key).collect{|member| JSON.parse member}
  end

  def spop
    JSON.parse @redis.spop(@key)
  end

  private

  def destroy_set
    @redis.del @key
  end

end