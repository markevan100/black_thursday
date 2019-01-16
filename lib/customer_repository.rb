require_relative 'ruby_helper'

class CustomerRepository

  attr_accessor :customers
  def initialize(filename)
    @customers = []

    CSV.foreach(filename, headers: true, :header_converters => :symbol, converters: :numeric) do |row|
      customer = Customer.new(row.to_hash)
      @customers << customer
    end
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
end
