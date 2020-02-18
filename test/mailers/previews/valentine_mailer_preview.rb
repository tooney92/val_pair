# Preview all emails at http://localhost:3000/rails/mailers/valentine_mailer
class ValentineMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/valentine_mailer/valentine_match
  def valentine_match
    ValentineMailer.valentine_match
  end

end
