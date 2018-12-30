class Item < Hash

  def initialize(attributes)
    self.merge!(attributes)
  end

  def id
    self[:id]
  end

  def name
    self[:name]
  end

  def description
    self[:description]
  end

  def unit_price
    self[:unit_price]
  end

  def created_at
    self[:created_at]
  end

  def updated_at
    self[:updated_at]
  end

  def unit_price_to_dollars
    self[:unit_price].to_f
  end

end
