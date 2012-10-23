class User
  attr_reader :first, :last, :email

  def initialize(args)
    args.each {|k,v| instance_variable_set("@#{k}", v) unless v.nil? }
  end

  def mail
    Mail.new.send(self)
  end

  def save
    binding.pry
  end

end
