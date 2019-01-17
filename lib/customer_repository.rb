require_relative 'ruby_helper'

class CustomerRepository

  attr_accessor :customers
  def initialize(filename)
    @customers = []

    CSV.foreach(filename, headers: true, :header_converters => :symbol, converters: :numeric) do |row|
      customer = Customer.new(row.to_hash)
      @customers << customer
    end
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def all
    customers
  end

  def find_by_id(id)
    customers.find { |i| i.id == id }
  end

  def find_all_by_first_name(fragment)
    customers.select { |i| i.first_name.downcase.include?(fragment.downcase) }
  end

  def find_all_by_last_name(fragment)
    customers.select { |i| i.last_name.downcase.include?(fragment.downcase) }
  end

  def create(some_attributes)
    num = self.current_id_max + 1
    attributes = {
      id: num,
      first_name: some_attributes[:first_name],
      last_name: some_attributes[:last_name],
      created_at: some_attributes[:created_at].to_s,
      updated_at: some_attributes[:updated_at].to_s,
    }
      customer = Customer.new(attributes)
      @customers << customer
  end

  def update(id, some_attributes)
    @customers.find do |i|
      if i.id == id
        if some_attributes[:first_name] != nil
          i.first_name = some_attributes[:first_name]
        end
        if some_attributes[:last_name] != nil
          i.last_name = some_attributes[:last_name]
        end

        i.updated_at = Time.now
      end
    end
  end

  def delete(id)
    @customers.delete_if { |i| i.id == id }
  end

  # #healper methods
  def current_id_max
    highest = @customers.max_by do |i|
      i.id
    end
    highest.id
  end
end
