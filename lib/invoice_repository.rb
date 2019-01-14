require_relative 'ruby_helper'

class InvoiceRepository

  attr_accessor :invoices
  def initialize(filename)
    @invoices = []

    CSV.foreach(filename, headers: true, :header_converters => :symbol) do |row|
      invoice = Invoice.new(row)

      @invoices << invoice
    end
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def all
    invoices
  end

  def find_by_id(id)
    invoices.find { |i| i.id == id }
  end

  def find_all_by_customer_id(c_id)
    invoices.select { |i| i.customer_id == c_id }
  end

  def find_all_by_merchant_id(m_id)
    invoices.select { |i| i.merchant_id == m_id }
  end

  def find_all_by_status(status)
    invoices.select { |i| i.status == status }
  end

  def create(some_attributes)
    num = self.current_id_max + 1
    attributes = {
      id: num,
      customer_id: some_attributes[:customer_id],
      merchant_id: some_attributes[:merchant_id],
      status: some_attributes[:status],
      created_at: some_attributes[:created_at].to_s,
      updated_at: some_attributes[:updated_at].to_s,
    }
      invoice = Invoice.new(attributes)
      @invoices << invoice
  end

  def update(id, some_attributes)
    @invoices.find do |i|
      if i.id == id
        i.status = some_attributes[:status]
        i.updated_at = Time.now
      end
    end
  end

  def delete(id)
    @invoices.delete_if { |i| i.id == id }
  end

  #healper methods
  def current_id_max
    highest = @invoices.max_by do |i|
      i.id
    end
    highest.id
  end
end
