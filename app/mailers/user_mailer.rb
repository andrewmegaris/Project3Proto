class UserMailer < ApplicationMailer
	default from: "group13proj4@yahoo.com"
  def account_activation(user)
    @user = user
    mail to:  @user.email, subject: "Account Activation"
  end

  
  def password_reset(user)
    @user = user
    mail to: @user.email, subject: "Password reset"
  end
  
end
