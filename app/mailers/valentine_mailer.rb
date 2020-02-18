class ValentineMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.valentine_mailer.valentine_match.subject
  #
  def valentine_match
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
