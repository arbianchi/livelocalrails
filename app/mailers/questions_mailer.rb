class QuestionsMailer < ApplicationMailer
  default from: "Pearl"

  def questions_mailer business_owner

    @owner = business_owner

    mail(to: @owner.email, 
         bcc: "adinab27@gmail.com",
         subject: 'You have a question!')

  end
end
