class Merchant
  attr_reader :id, :name, :created_at, :updated_at
  def initialize(attributes)
    # require "pry"; binding.pry if attributes[:id] == 12337412
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @created_at = attributes[:created_at] ||= Date.today
    @updated_at = attributes[:updated_at] ||= Date.today
  end
end
