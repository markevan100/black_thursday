class Item

  attr_accessor :id, :name, :description, :created_at, :updated_at, :unit_price, :merchant_id
  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @description = attributes[:description]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @unit_price = attributes[:unit_price]
    @merchant_id = attributes[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
