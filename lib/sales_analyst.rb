require_relative 'ruby_helper'

class SalesAnalyst

  attr_reader :merchants, :items
  def initialize(merchants, items)
    @merchants = merchants
    @items = items
  end

  def average_items_per_merchant
    (items.all.count / uniq_merch_ids.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    blank_array = []
    uniq_merch_ids.each do |n|
      blank_array << uniq_merch_ids.count(n)
    end
    mean = blank_array.inject(:+) / blank_array.length.to_f
    var_sum = blank_array.map{|n| (n-mean)**2}.inject(:+).to_f
    sample_variance = var_sum / (blank_array.length - 1)
    Math.sqrt(sample_variance).round(2)
  end

  def merchants_with_high_item_count
    merchants_ids_with_more_than_seven_items = []
    uniq_merch_ids.each do |merch|
      merchants_ids_with_more_than_seven_items << merch if non_unique_merch_ids.count(merch) >= 7
    end
    high_item_count_merch_objects = []

    merchants_ids_with_more_than_seven_items.each do |i|
      high_item_count_merch_objects << merchants.find_by_id(i)
    end
    return high_item_count_merch_objects
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
    averages_array = []
    all_merchant_ids.each do |m_id|
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
  
  private
  
    def all_merchant_ids
      @merchants.all.map(&:id)
    end
    
    def non_unique_merch_ids
      items.all.map { |i| i.merchant_id }
    end
    
    def uniq_merch_ids
      items.all.map { |i| i.merchant_id }.uniq
    end
end
