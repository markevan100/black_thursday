require_relative 'ruby_helper'
#'./data/items.csv'

class ItemRepository

  attr_accessor :items
  def initialize(filename)
    @items = []

    CSV.foreach(filename, headers: true, :header_converters => :symbol, converters: :numeric) do |row|
      item = Item.new(row.to_hash)
      @items << item
    end
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def all
    items
  end

  def find_by_id(id)
    items.find do |i|
      i.id == id
    end
  end

  def find_by_name(name)
    items.find do |i|
      i.name == name
    end
  end


  def find_all_with_description(description)
    array = []
    items.find_all do |i|
      array << i if i.description.downcase.include?(description.downcase)
    end
    array
  end

  def find_all_by_price(price)
    array = []
    items.find_all do |i|
      array << i if i.unit_price == (price.to_i * 100)
    end
    array
  end

  def find_all_by_price_in_range(price_range)
    array = []
    items.find_all do |i|
      array << i if i.unit_price >= (price_range.min.to_i * 100) && i.unit_price <= (price_range.max.to_i * 100)
    end
    array
  end

  def find_all_by_merchant_id(merchant_id)
    array = []
    items.find_all do |i|
      array << i if i.merchant_id == merchant_id
    end
    array
  end

  def current_id_max
    highest = @items.max_by do |i|
      i.id
    end
    highest.id
  end

  def create(some_attributes)
    num = self.current_id_max + 1
    attributes = {
      id: num,
      name: some_attributes[:name],
      description: some_attributes[:description],
      created_at: some_attributes[:created_at],
      updated_at: some_attributes[:updated_at],
      unit_price: some_attributes[:unit_price],
      merchant_id: some_attributes[:merchant_id]
    }
      item = Item.new(attributes)
      @items << item
  end

  def update(id, some_attributes)
    @items.find do |i|
      if i.id == id
        i.name = some_attributes[:name] if some_attributes[:name] != nil
        i.description = some_attributes[:description] if some_attributes[:description] != nil
        i.unit_price = some_attributes[:unit_price] if some_attributes[:unit_price] != nil
        i.updated_at = Time.now
      end
    end
  end

  def delete(id)
    @items.delete_if { |i| i.id == id }
  end

end
