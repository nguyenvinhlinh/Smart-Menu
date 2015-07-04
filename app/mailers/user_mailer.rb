class UserMailer < ApplicationMailer
  default from: "smartmenuinfo@gmail.com"
  def welcome_email(customer)
    @customer = customer
    @url = 'example.com'
    mail(to: @customer.email, subject: "This is a test email")

  end

  def send_invite(invite)
    # assume this is the json object
    #
    # invite: {
    #   hostName: 'Test Host'
    #   receiverEmail: 'test@example.com'
    #   eventName: 'asdf'
    #   eventDateTime: 2015-01-15 11:00:00
    #   restaurantName: 'Fancy Restaurant'
    # }
    #
    @invite = invite
    @url = 'http://10.0.0.74:3000/customers/new'
    subject = @invite[:hostName] + " has invited you to join " + @invite[:eventName]
    mail(to:@invite[:receiverEmail], subject: subject)
  end

end
