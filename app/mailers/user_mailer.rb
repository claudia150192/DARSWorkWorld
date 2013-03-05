class UserMailer < ActionMailer::Base
  default :from => "asime@opensourceconnections.com"
  def welcome_email(user)
    @user = user
    @url = login_url
    mail(:to=> @user.email, :subject=> "Welcome to WorkWorld on the Web!")
  end

  def activation_instructions(user)
    @user = user
    @url = activation_url(@user.perishable_token)
    mail(:to=> @user.email, :subject => "Activate your Account!")
  end

  def shared_file(user, kase)
    @user = user
    @url = open_case_url kase.id
    mail(:to=>@user.email, :subject=>"A file has been shared with you")
  end
end
