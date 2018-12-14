require 'pry'
require 'csv'

class MerchantRepository

  attr_accessor :merchants
  def initialize
    @merchants = []

    CSV.foreach('../data/merchants.csv', headers: true, :header_converters => :symbol, converters: :numeric) do |row|
      merchant = Merchant.new
      merchant = row.to_hash
      @merchants << merchant
    end
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |m|
      m[:id] == id
    end
  end

  def find_by_name(name)
    @merchants.find do |m|
      m[:name] == name
    end
  end

  def find_all_by_name(name)
    array = []
    mer = @merchants.find_all do |m|
      array << m[:name] if m[:name].include?(name)
    end
    array
  end

  def current_id_max
    highest = @merchants.max_by do |m|
      m[:id]
    end
    highest[:id]
  end

  def create(name)
    num = self.current_id_max + 1
    new_one = Merchant.new
      new_one[:id] = num
      new_one[:name] = name
      new_one[:created_at] = Time.now.strftime("%m/%d/%Y")
      new_one[:updated_at] = Time.now.strftime("%m/%d/%Y")

      @merchants << new_one
  end
end
