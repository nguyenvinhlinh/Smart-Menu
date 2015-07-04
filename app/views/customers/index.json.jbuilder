json.array!(@customers) do |customer|
  json.extract! customer, :id, :name, :email, :hating_ingredient, :loving_taste
  json.url customer_url(customer, format: :json)
end
