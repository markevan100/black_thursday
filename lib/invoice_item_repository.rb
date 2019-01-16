require_relative 'ruby_helper'

class InvoiceItemRepository

  attr_accessor :invoice_items
  def initialize(filename)
    @invoice_items = []

    CSV.foreach(filename, headers: true, :header_converters => :symbol, converters: :numeric) do |row|
      invoice_item = InvoiceItem.new(row.to_hash)
      @invoice_items << invoice_item
    end
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def all
    invoice_items
  end

  def find_by_id(id)
    invoice_items.find { |i| i.id == id }
  end

  def find_all_by_item_id(i_id)
    invoice_items.select { |i| i.item_id == i_id }
  end

  def find_all_by_invoice_id(i_id)
    invoice_items.select { |i| i.invoice_id == i_id }
  end

  def create(some_attributes)
    num = self.current_id_max + 1
    attributes = {
      id: num,
      item_id: some_attributes[:item_id],
      invoice_id: some_attributes[:invoice_id],
      quantity: some_attributes[:quantity],
      unit_price: some_attributes[:unit_price],
      created_at: some_attributes[:created_at].to_s,
      updated_at: some_attributes[:updated_at].to_s,
    }
      invoice_item = InvoiceItem.new(attributes)
      @invoice_items << invoice_item
  end

  def update(id, some_attributes)
    @invoice_items.find do |i|
      if i.id == id
        i.quantity = some_attributes[:quantity]
        i.updated_at = Time.now
      end
    end
  end

  def delete(id)
    @invoice_items.delete_if { |i| i.id == id }
  end

  # #healper methods
  def current_id_max
    highest = @invoice_items.max_by do |i|
      i.id
    end
    highest.id
  end
end
