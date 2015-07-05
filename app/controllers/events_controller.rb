class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:api_new_event]
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def api_new_event
    puts "#################### api_new_event #{params}"
    _host_email = params[:host_email]
    _name = params[:name]
    _pending_email = params[:pending_email]
    _address = params[:address]
    _image = params[:image]
    _occur_date = params[:date]

    params.each  do |key,value|
      puts "#{key}:=> #{value}"
    end
    event = Event.create(host_email: _host_email,
                         name: _name,
                         pending_email: _pending_email,
                         address: _address,
                         image: _image,
                         occur_date: _occur_date
                       )

    if event.save
      email_array = _pending_email.split(",")
      email_array.each do |f|
        f = f.strip!
        invite = {
          hostName: _host_email,
          receiverEmail: f,
          eventName: _name,
          restaurantName: _name,
          eventDateTime: _occur_date
        }
        UserMailer.send_invite(invite)
      end
    end

    json = JSONBuilder::Compiler.generate do
      code "200"
    end

    respond_to do |format|
      format.html {render json: json}
      format.json {render json: json}
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:host_email,:image, :name, :accept_email,
                                    :decline_email, :pending_email, :address,
                                    :occur_date, :date)
    end
end
