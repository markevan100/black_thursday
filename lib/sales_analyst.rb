require_relative 'ruby_helper'

class SalesAnalyst

  attr_reader :merchants, :items
  def initialize(merchants, items)
    @merchants = merchants
    @items = items
  end

  def average_items_per_merchant
    array = []
    items.all.each { |i| array << i.merchant_id }
    (array.count / array.uniq.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    array = []
    items.all.each { |i| array << i.merchant_id }
    uni_array = array.uniq
    blank_array = []
    uni_array.each do |n|
      blank_array << array.count(n)
    end
    mean = blank_array.inject(:+) / blank_array.length.to_f
    var_sum = blank_array.map{|n| (n-mean)**2}.inject(:+).to_f
    sample_variance = var_sum / (blank_array.length - 1)
    Math.sqrt(sample_variance).round(2)
  end

  def merchants_with_high_item_count
    array = []
    items.all.each { |i| array << i.merchant_id }
    uni_array = array.uniq
    blank_array = []
    uni_array.each do |n|
      blank_array << n if array.count(n) >= 7
    end
    second_array = []

    blank_array.each do |i|
      second_array << merchants.find_by_id(i)
    end
    return second_array
  end

  def average_item_price_for_merchant(merchant_id)
    items_array = items.find_all_by_merchant_id(merchant_id)
    price_array = []
    items_array.each do |i|
      price_array << i.unit_price
    end
    average = price_array.inject(:+) / price_array.length
    y = average.to_f.round(2)
    x = (y * 100).to_i
    BigDecimal.new(x)/100
  end

  def average_average_price_per_merchant
    merch_id_array = []
    merchants.all.each do |m|
      merch_id_array << m.id
    end
    averages_array = []
    merch_id_array.each do |m_id|
      items_array = items.find_all_by_merchant_id(m_id)
      price_array = []
      items_array.each do |i|
        price_array << i.unit_price
      end
      average = price_array.inject(:+) / price_array.length
      averages_array << average
    end
    total_average = averages_array.inject(:+) / averages_array.length
    y = total_average.to_f.round(2)
    x = (y * 100).to_i
    BigDecimal.new(x)/100
  end
end
