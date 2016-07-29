class AnswersMailer < ApplicationMailer

  default from: "Pearl"

  def answers_mailer user

    @user = user

    mail(to: @user.email, 
         bcc: "adinab27@gmail.com",
         subject: 'You have an answer to your question!')
  end
end
