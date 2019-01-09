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
end
