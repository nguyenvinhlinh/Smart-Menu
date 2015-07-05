class InvitesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  def create
    @invite = invite_params
    UserMailer.send_invite(@invite).deliver_now
  end
  private
  def invite_params

    params.permit(:eventName, :hostName, :receiverEmail, :eventDateTime, :restaurantName, :hostid)
  end
end
