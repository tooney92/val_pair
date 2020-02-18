require 'test_helper'

class ValentineMailerTest < ActionMailer::TestCase
  test "valentine_match" do
    mail = ValentineMailer.valentine_match
    assert_equal "Valentine match", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
