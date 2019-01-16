require_relative 'ruby_helper'

class TransactionRepository

  attr_accessor :transactions
  def initialize(filename)
    @transactions = []

    CSV.foreach(filename, headers: true, :header_converters => :symbol, converters: :numeric) do |row|
      transaction = Transaction.new(row.to_hash)
      @transactions << transaction
    end
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def all
    transactions
  end

  def find_by_id(id)
    transactions.find { |i| i.id == id }
  end

  def find_all_by_invoice_id(i_id)
    transactions.select { |i| i.invoice_id == i_id }
  end

  def find_all_by_credit_card_number(cc_num)
    transactions.select { |i| i.credit_card_number == cc_num }
  end

  def find_all_by_result(result)
    transactions.select { |i| i.result == result }
  end

  def create(some_attributes)
    num = self.current_id_max + 1
    attributes = {
      id: num,
      invoice_id: some_attributes[:invoice_id],
      credit_card_number: some_attributes[:credit_card_number],
      credit_card_expiration_date: some_attributes[:credit_card_expiration_date],
      result: some_attributes[:result],
      created_at: some_attributes[:created_at].to_s,
      updated_at: some_attributes[:updated_at].to_s,
    }
      transaction = Transaction.new(attributes)
      @transactions << transaction
  end

  def update(id, some_attributes)
    @transactions.find do |i|
      if i.id == id
        i.result = some_attributes[:result]
        i.updated_at = Time.now
      end
    end
  end

  def delete(id)
    @transactions.delete_if { |i| i.id == id }
  end

  # #healper methods
  def current_id_max
    highest = @transactions.max_by do |i|
      i.id
    end
    highest.id
  end
end
