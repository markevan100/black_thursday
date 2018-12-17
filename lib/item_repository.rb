require 'pry'
require 'csv'

class ItemRepository

  attr_accessor :items
  def initialize
    @items = []

    CSV.foreach('./data/items.csv', headers: true, :header_converters => :symbol, converters: :numeric) do |row|
      item = Item.new
      item = row.to_hash
      @items << item
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |i|
      i[:id] == id
    end
  end

  def find_by_name(name)
    @items.find do |i|
      i[:name] == name
    end
  end

  def find_all_by_name(name)
    array = []
    @items.find_all do |i|
      array << i[:name] if i[:name].include?(name)
    end
    array
  end

  def current_id_max
    highest = @items.max_by do |i|
      i[:id]
    end
    highest[:id]
  end

  def create(name, description, unit_price, merchant_id)
    num = self.current_id_max + 1
    new_one = Item.new
      new_one[:id] = num
      new_one[:name] = name
      new_one[:description] = description
      new_one[:unit_price] = BigDecimal.new(unit_price,4)
      new_one[:created_at] = Time.now.strftime("%m/%d/%Y")
      new_one[:updated_at] = Time.now.strftime("%m/%d/%Y")
      new_one[:merchant_id] = merchant_id

      @items << new_one
  end

  def update(id, name, description, unit_price, merchant_id)
    @items.find do |i|
      if i[:id] == id
        i[:name] = name
        i[:description] = description
        i[:unit_price] = unit_price
        i[:merchant_id] = merchant_id
      end
    end
  end

  def delete(id)
    @items.delete_if { |i| i[:id] == id }
  end

end
