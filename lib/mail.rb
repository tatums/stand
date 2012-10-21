class Mail
  require 'net/smtp'

  def initialize
    @smtp =  Net::SMTP.new Stand::CONFIG['mail']['host'], Stand::CONFIG['mail']['port']
  end

  def send(user)
    @message = "Subject: Stand Status\n\n
                Hey #{user.first} you were absent for the daily stand.
                Please send us your status. \n\n
                Thank You."

    @smtp.enable_starttls
    @smtp.start('tkmltech.com', Stand::CONFIG['mail']['user'], Stand::CONFIG['mail']['password'], :login) do
      @smtp.send_message(@message, Stand::CONFIG['mail']['from'], user.email)
    end

  end

end
