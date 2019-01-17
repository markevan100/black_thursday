require_relative 'ruby_helper'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'

class SalesAnalyst

  attr_reader :merchants, :items, :invoices, :invoice_items, :transactions, :customers
  def initialize(merchants, items, invoices, invoice_items, transactions, customers)
    @merchants = merchants
    @items = items
    @invoices = invoices
    @invoice_items = invoice_items
    @transactions = transactions
    @customers = customers
  end

  def average_items_per_merchant
    (merchant_ids_items.count / merchant_ids_items.uniq.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(unique_merchants.map { |n| merchant_ids_items.count(n) })
  end

  def merchants_with_high_item_count
    (unique_merchants.select { |n| merchant_ids_items.count(n) >= 7 }).map { |i| merchants.find_by_id(i) }
  end

  def average_item_price_for_merchant(merchant_id)
    price_array = items.find_all_by_merchant_id(merchant_id).map { |i| i.unit_price }
    Kernel.BigDecimal((mean(price_array).to_f.round(2) * 100).to_i)/100
  end

  def average_average_price_per_merchant
    averages_array = unique_merchants.map do |m_id|
      mean(items.find_all_by_merchant_id(m_id).map { |i| i.unit_price })
    end
    Kernel.BigDecimal((mean(averages_array).to_f.round(2) * 100).to_i)/100
  end

  def golden_items
    item_price_array = items.all.map { |i| i.unit_price }
    item_mean = mean(item_price_array)
    strd_dev = standard_deviation(item_price_array)
    golden_price = item_mean + (strd_dev * 2)
    items.all.select { |i| i.unit_price > golden_price }
  end

  def average_invoices_per_merchant
    all_m_ids_array = invoices.all.map { |i| i.merchant_id }
    (all_m_ids_array.count / all_m_ids_array.uniq.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    all_m_ids_array = invoices.all.map { |i| i.merchant_id }
    standard_deviation(all_m_ids_array.uniq.map { |n| all_m_ids_array.count(n) })
  end

  def top_merchants_by_invoice_count
    invoice_array = unique_merchants.map { |n| merchant_ids_invoices.count(n) }
    invoice_mean = mean(invoice_array)
    strd_dev = standard_deviation(invoice_array)
    top_merch = invoice_mean + (strd_dev * 2)
    top_merchant_ids = unique_merchants.select { |i| merchant_ids_invoices.count(i) >= top_merch}
    top_merchant_ids.map { |i| merchants.find_by_id(i) }
  end

  def bottom_merchants_by_invoice_count
    invoice_array = unique_merchants.map { |n| merchant_ids_invoices.count(n) }
    invoice_mean = mean(invoice_array)
    strd_dev = standard_deviation(invoice_array)
    top_merch = invoice_mean - (strd_dev * 2)
    top_merchant_ids = unique_merchants.select { |i| merchant_ids_invoices.count(i) <= top_merch}
    top_merchant_ids.map { |i| merchants.find_by_id(i) }
  end

  def top_days_by_invoice_count
    invoice_days_array = invoices.all.map { |i| i.created_at.strftime('%A')}
    number_of_each_day_arrray = invoice_days_array.uniq.map { |d| invoice_days_array.count(d) }
    invoice_days_mean = mean(number_of_each_day_arrray)
    strd_dev = standard_deviation(number_of_each_day_arrray)
    top_days = invoice_days_mean + strd_dev
    invoice_days_array.uniq.select { |d| top_days < invoice_days_array.count(d) }
  end

  def invoice_status(status)
    status_array = invoices.all.select { |i| i.status == status }
    ((status_array.count / invoices.all.count.to_f) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    trans = transactions.find_all_by_invoice_id(invoice_id)
    if trans.count == 0
      return false
    end
    trans.select { |t| t.result == :success }.length > 0
  end

  def invoice_total(invoice_id)
    invoice_items_array = invoice_items.find_all_by_invoice_id(invoice_id)
    invoice_items_array.map { |i| i.quantity * i.unit_price }.inject(:+)
  end
  #Helper methods
  private
  def merchant_ids_items
    items.all.map { |i| i.merchant_id }
  end

  def merchant_ids_invoices
    invoices.all.map { |i| i.merchant_id }
  end

  def unique_merchants
    merchant_ids_items.uniq
  end

  def mean(array)
    array.inject(:+) / array.length.to_f
  end

  def standard_deviation(array)
    mean = array.inject(:+) / array.length.to_f
    var_sum = array.map{|n| (n-mean)**2}.inject(:+).to_f
    sample_variance = var_sum / (array.length - 1)
    Math.sqrt(sample_variance).round(2)
  end
end
