require_relative 'ruby_helper'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'sales_analyst'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'

class SalesEngine

  attr_reader :merchants, :items, :analyst, :invoices, :invoice_items, :customers, :transactions
  def initialize(file_paths)
    @merchants ||= MerchantRepository.new(file_paths[:merchants])
    @items ||= ItemRepository.new(file_paths[:items])
    @invoices = InvoiceRepository.new(file_paths[:invoices])
    @invoice_items = InvoiceItemRepository.new(file_paths[:invoice_items])
    @customers = CustomerRepository.new(file_paths[:customers])
    @transactions = TransactionRepository.new(file_paths[:transactions])
    @analyst = SalesAnalyst.new(@merchants, @items, @invoices, @invoices_items, @transactions, @customers)
  end

  def self.from_csv(file_paths)
    SalesEngine.new(file_paths)
  end
end
