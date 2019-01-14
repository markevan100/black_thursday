require_relative 'ruby_helper'
#'./data/merchants.csv'

class MerchantRepository

  attr_accessor :merchants
  def initialize(filename)
    @merchants = []

    CSV.foreach(filename, headers: true, :header_converters => :symbol) do |row|
      merchant = Merchant.new(row)
      @merchants << merchant
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    merchants
  end

  def find_by_id(id)
    merchants.find do |m|
      m.id == id
    end
  end

  def find_by_name(name)
    merchants.find do |m|
      m.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    array = []
    merchants.find_all do |m|
      array << m if m.name.downcase.include?(name.downcase)
    end
    array
  end

  def current_id_max
    highest = merchants.max_by do |m|
      m.id
    end
    highest.id
  end

  def create(name_hash)
    num = self.current_id_max + 1
    attributes = {
      id: num,
      name: name_hash[:name],
      created_at: Time.now.strftime("%m/%d/%Y"),
      updated_at: Time.now.strftime("%m/%d/%Y")
    }
      merchant = Merchant.new(attributes)
      @merchants << merchant
  end

  def update(id, attributes)
    @merchants.find do |m|
      m.name = attributes[:name] if m.id == id
    end
  end

  def delete(id)
    @merchants.delete_if { |m| m.id == id }
  end

end
