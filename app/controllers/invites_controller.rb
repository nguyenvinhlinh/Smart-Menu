class InvitesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def show
    
  end
  
  def create
    @invite = invite_params
    UserMailer.send_invite(@invite).deliver_now

    
    response_to do |f|
      f.json {render json: nil}
      f.html {render json: nil}
    end
  end
  private
  def invite_params

    params.require(:invite).permit(:eventName, :hostName, :receiverEmail, :eventDateTime, :restaurantName, :hostid)
  end
end
