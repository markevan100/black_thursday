require_relative 'ruby_helper'

class SalesEngine

  attr_reader :file_paths, :merchants, :items
  def initialize(file_paths)
    @file_paths = file_paths
    @merchants = MerchantRepository.new(file_paths[:merchants])
    @items = ItemRepository.new(file_paths[:items])
  end

  def self.from_csv(file_paths)
    SalesEngine.new(file_paths)
  end

  # def merchants
  #   MerchantRepository.new(hash[:merchants])
  # end

  # def items
  #   ItemRepository.new(hash[:items])
  # end
end
