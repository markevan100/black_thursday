require_relative 'ruby_helper'

class SalesEngine

  attr_reader :merchant_repository
  def initialize(data)
    @merchant_repository = build_merchants(data[:merchants])
    # @items = build_items
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

  def build_merchants(file_path)
    MerchantRepository.new(file_path)
  end 

  # def build_items
  #   ItemRepository.new(hash[:items])
  # end
end
