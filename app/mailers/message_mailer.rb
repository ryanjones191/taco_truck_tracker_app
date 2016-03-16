class MessageMailer < ActionMailer::Base

  default from: "Taco Truck Tracker <noreply@taco-truck-tracker-app.com>"
  default to: "Taco Truck Tracker <tttinterns@gmail.com>"

  def new_message(message)
    @message = message
    
    mail subject: "Message from #{message.name}"
  end

end