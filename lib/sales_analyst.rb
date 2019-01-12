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
    standard_deviation(unique_merchants.map { |n| merchant_ids.count(n) })
  end

  def merchants_with_high_item_count
    (unique_merchants.select { |n| merchant_ids.count(n) >= 7 }).map { |i| merchants.find_by_id(i) }
  end

  def average_item_price_for_merchant(merchant_id)
    price_array = items.find_all_by_merchant_id(merchant_id).map { |i| i.unit_price }
    BigDecimal.new((mean(price_array).to_f.round(2) * 100).to_i)/100
  end

  def average_average_price_per_merchant
    averages_array = unique_merchants.map do |m_id|
      mean(items.find_all_by_merchant_id(m_id).map { |i| i.unit_price })
    end
    BigDecimal.new((mean(averages_array).to_f.round(2) * 100).to_i)/100
  end

  def golden_items
    item_price_array = items.all.map { |i| i.unit_price }
    item_mean = mean(item_price_array)
    strd_dev = standard_deviation(item_price_array)
    golden_price = item_mean + (strd_dev * 2)
    items.all.select { |i| i.unit_price > golden_price }
  end

  #Helper methods
  private
  def merchant_ids
    items.all.map { |i| i.merchant_id }
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
