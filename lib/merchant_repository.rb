require 'pry'
require 'csv'

class MerchantRepository

  attr_accessor :merchants
  def initialize
    @merchants = []

    CSV.foreach('../data/merchants.csv', headers: true, :header_converters => :symbol, converters: :numeric) do |row|
      merchant = Merchant.new
      merchant = row.to_hash
      @merchants << merchant
    end
  end
end
