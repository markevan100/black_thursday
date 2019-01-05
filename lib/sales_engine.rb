require_relative 'ruby_helper'

class SalesEngine

  attr_reader :hash
  def initialize(hash)
    @hash = hash
  end

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  def merchants
    MerchantRepository.new(hash[:merchants])
  end

  # def items
  #   ItemRepository.new(hash[:items])
  # end
end

  #
  # def self.merchants
  #   h = self
  #   g = MerchantRepository.new(h[:merchants])
  #   binding.pry
  # end
