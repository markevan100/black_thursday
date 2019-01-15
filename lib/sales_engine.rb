require_relative 'ruby_helper'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'sales_analyst'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'

class SalesEngine

  attr_reader :merchants, :items, :analyst, :invoices, :invoices_items
  def initialize(file_paths)
    @merchants ||= MerchantRepository.new(file_paths[:merchants])
    @items ||= ItemRepository.new(file_paths[:items])
    @invoices = InvoiceRepository.new(file_paths[:invoices])
    @invoices_items = InvoiceItemRepository.new(file_paths[:invoices_items])
    @analyst = SalesAnalyst.new(@merchants, @items, @invoices, @invoices_items)
  end

  def self.from_csv(file_paths)
    SalesEngine.new(file_paths)
  end
end
