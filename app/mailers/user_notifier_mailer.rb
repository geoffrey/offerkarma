class UserNotifierMailer < ApplicationMailer
  default from: 'geoffrey@reffo.us'

 # send a signup email to the user
 def send_signup_email(user, verification_token)
   @user = user
   @verification_token = verification_token
   mail(to: @user.email, subject: 'Welcome to reffo')
 end
end
