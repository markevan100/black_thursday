require_relative 'ruby_helper'

class SalesEngine

  attr_reader :merchants, :items, :analyst
  def initialize(file_paths)
    @merchants ||= MerchantRepository.new(file_paths[:merchants])
    @items ||= ItemRepository.new(file_paths[:items])
    @analyst = SalesAnalyst.new(@merchants, @items)
  end

  def self.from_csv(file_paths)
    SalesEngine.new(file_paths)
  end
end
