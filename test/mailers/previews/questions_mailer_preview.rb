class QuestionsMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    QuestionsMailerPreview.sample_email(User.first)
  end
end
