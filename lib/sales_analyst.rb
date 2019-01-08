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
end


# def average_items_per_merchant_standard_deviation
#
# mean = list.inject(:+) / list.length.to_f
# var_sum = list.map{|n| (n-mean)**2}.inject(:+).to_f
# sample_variance = var_sum / (list.length - 1)
# Math.sqrt(sample_variance)
# end
