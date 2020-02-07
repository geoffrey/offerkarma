class UserNotifierMailer < ApplicationMailer
  default from: 'Geoffrey from OfferKarma <geoffrey@offerkarma.com>'

 def signup_email(user, verification_token)
   @user = user
   @verification_token = verification_token
   mail(to: @user.email, subject: 'Welcome to OfferKarma')
 end
end
