json.array!(@events) do |event|
  json.extract! event, :id, :host_email, :name, :accept_email, :decline_email, :pending_email, :address, :occur_date
  json.url event_url(event, format: :json)
end
