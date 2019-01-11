require_relative 'ruby_helper'

class SalesAnalyst

  attr_reader :merchants, :items
  def initialize(merchants, items)
    @merchants = merchants
    @items = items
  end

  def average_items_per_merchant
    (merchant_ids.count / merchant_ids.uniq.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant = []
    unique_merchants.each { |n| items_per_merchant << merchant_ids.count(n) }
    standard_deviation(items_per_merchant)
  end

  def merchants_with_high_item_count
    high_item_merchant_ids = []
    unique_merchants.each { |n| high_item_merchant_ids << n if merchant_ids.count(n) >= 7 }

    merchants_for_high_item = []
    high_item_merchant_ids.each { |i| merchants_for_high_item << merchants.find_by_id(i) }
    merchants_for_high_item
  end

  def average_item_price_for_merchant(merchant_id)
    items_array = items.find_all_by_merchant_id(merchant_id)
    price_array = []
    items_array.each { |i| price_array << i.unit_price }
    average = price_array.inject(:+) / price_array.length
    y = average.to_f.round(2)
    x = (y * 100).to_i
    BigDecimal.new(x)/100
  end

  def average_average_price_per_merchant
    averages_array = []
    unique_merchants.map do |m_id|
      items_array = items.find_all_by_merchant_id(m_id)
      price_array = []
      items_array.select do |i|
        price_array << i.unit_price
      end
      averages_array << mean(price_array)
    end
    BigDecimal.new((mean(averages_array).to_f.round(2) * 100).to_i)/100
  end

  def golden_items
    item_price_array = []
    items.all.each { |i| item_price_array << i.unit_price }
    item_mean = mean(item_price_array)
    strd_dev = standard_deviation(item_price_array)
    golden_items = []
    golden_price = item_mean + (strd_dev * 2)
    items.all.each { |i| golden_items << i if i.unit_price > golden_price}
    golden_items
  end

  #Helper methods
  private
  def merchant_ids
    array_of_merchant_ids = []
    items.all.each { |i| array_of_merchant_ids << i.merchant_id }
    array_of_merchant_ids
  end

  def unique_merchants
    merchant_ids.uniq
  end

  def mean(array)
    mean = array.inject(:+) / array.length.to_f
  end

  def standard_deviation(array)
    mean = array.inject(:+) / array.length.to_f
    var_sum = array.map{|n| (n-mean)**2}.inject(:+).to_f
    sample_variance = var_sum / (array.length - 1)
    Math.sqrt(sample_variance).round(2)
  end
end
