class UserNotifierMailer < ApplicationMailer
  default from: 'Geoffrey from Reffo <geoffrey@reffo.us>'

 def signup_email(user, verification_token)
   @user = user
   @verification_token = verification_token
   mail(to: @user.email, subject: 'Welcome to Reffo')
 end
end
