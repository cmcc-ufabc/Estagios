require 'test_helper'

class CancelamentoMailerTest < ActionMailer::TestCase
  test "cancelamentos" do
    mail = CancelamentoMailer.cancelamentos
    assert_equal "Cancelamentos", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "user_mailer" do
    mail = CancelamentoMailer.user_mailer
    assert_equal "User mailer", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "user" do
    mail = CancelamentoMailer.user
    assert_equal "User", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
