class QuestionsMailer < ApplicationMailer
  default from: "livelocalrails.herokuapp.com"

  def questions_mailer business_owner

    @owner = business_owner

    mail(to: "", 
         bcc: "",
         subject: 'You have a question!')

  end
end
