class User

  attr_reader :first, :last, :email

  def initialize(args)
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  def mail
    Mail.new.send(self)
  end

end
