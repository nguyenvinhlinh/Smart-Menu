class UserMailer < ApplicationMailer
  default from: "smartmenuinfo@gmail.com"
  def welcome_email(customer)
    @customer = customer
    @url = 'example.com'
    mail(to: @customer.email, subject: "Thank you for sending in your preferences!")

  end

  def notify_host(host, customer)
    @host = host
    @customer = customer
    mail(to: @host[:email], subject: "Invitation Accepted")
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

    emailList = invite[:receiverEmail].split(',')
    puts emailList
    @url = 'http://10.0.0.74:3000/customers/new?hostid=' + @invite[:hostid].to_s
    subject = invite[:hostName] + " has invited you to join " + invite[:eventName]
    emailList.each do |item|
      @invite = invite
      @invite[:receiverEmail] = item
      mail(to:@invite[:receiverEmail], subject: subject)
    end

  end

end
