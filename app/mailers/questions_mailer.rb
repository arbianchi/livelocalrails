class QuestionsMailer < ApplicationMailer
  default from: "livelocalrails.herokuapp.com"

  def questions_mailer business_owner

    @owner = business_owner

    mail(to: "adinab27@gmail.com", 
         bcc: "adinab27@gmail.com",
         subject: 'You have a question!')

    # mg_client = Mailgun::Client.new ENV['api_key']
    # message_params = {:from    => 'pearl@pearl.com',
    #   :to      => 'adinab27@gmail.com',
    #   :subject => 'Sample Mail using Mailgun API',
    #   :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
    # mg_client.send_message ENV['domain'], message_params
  end
end
