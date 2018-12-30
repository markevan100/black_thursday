class Merchant < Hash


  def initialize(attributes)
    self.merge!(attributes)
  end

  def id
    self[:id]
  end

  def name
    self[:name]
  end

end
