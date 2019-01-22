require_relative 'test_helper'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv",
    })

    @an = @se.analyst
  end
  #
  # def test_average_items_per_merchant
  #   expected = @an.average_items_per_merchant
  #   assert_equal 2.88, expected
  #   assert_instance_of Float, expected
  # end
  #
  # def test_average_items_per_merchant_standard_deviation
  #   expected = @an.average_items_per_merchant_standard_deviation
  #   assert_equal 3.26, expected
  #   assert_instance_of Float, expected
  # end
  #
  # def test_merchants_with_high_item_count_returns_merchants_more_than_one_standard_deviation
  #   expected = @an.merchants_with_high_item_count
  #   assert_equal 52, expected.length
  #   assert_instance_of Merchant, expected.first
  # end
  #
  # def test_average_item_price_for_merchant_returns_the_average_item_price
  #   merchant_id = 12334105
  #   expected = @an.average_item_price_for_merchant(merchant_id)
  #
  #   assert_equal 16.66, expected
  #   assert_instance_of BigDecimal, expected
  # end
  #
  # def test_it_average_average_price_per_merchant_returns_the_average_price_for_all_merchants
  #   expected = @an.average_average_price_per_merchant
  #
  #   assert_equal 350.29, expected
  #   assert_instance_of BigDecimal, expected
  # end
  #
  # def test_golden_items_returns_items_that_are_two_standard_deviations_above_the_average_price
  #   expected = @an.golden_items
  #
  #   assert_equal 5, expected.length
  #   assert_instance_of Item, expected.first
  # end
  #
  # def test_average_invoices_per_merchant_returns_average_number_of_invoices_per_merchant
  #   expected = @an.average_invoices_per_merchant
  #
  #   assert_equal 10.49, expected
  #   assert_instance_of Float, expected
  # end
  #
  # def test_average_invoices_per_merchant_standard_deviation_returns_the_standard_deviation
  #   expected = @an.average_invoices_per_merchant_standard_deviation
  #
  #   assert_equal 3.29, expected
  #   assert_instance_of Float, expected
  # end
  #
  # def test_top_merchants_by_invoice_count_returns_merchants_that_are_two_standard_deviations_above_the_mean
  #   expected = @an.top_merchants_by_invoice_count
  #
  #   assert_equal 12, expected.length
  #   assert_instance_of Merchant, expected[0]
  # end
  #
  # def test_bottom_merchants_by_invoice_count_returns_merchants_that_are_two_standard_deviations_below_the_mean
  #   expected = @an.bottom_merchants_by_invoice_count
  #
  #   assert_equal 4, expected.length
  #   assert_instance_of Merchant, expected[0]
  # end
  #
  # def test_top_days_by_invoice_count_returns_days_with_an_invoice_count_more_than_one_standard_deviation_above_the_mean
  #   expected = @an.top_days_by_invoice_count
  #
  #   assert_equal 1, expected.length
  #   assert_equal "Wednesday", expected.first
  #   assert_instance_of String, expected.first
  # end
  #
  # def test_invoice_status_returns_the_percentage_of_invoices_with_given_status
  #   expected = @an.invoice_status(:pending)
  #
  #   assert_equal 29.55, expected
  #
  #   expected = @an.invoice_status(:shipped)
  #
  #   assert_equal 56.95, expected
  #
  #   expected = @an.invoice_status(:returned)
  #
  #   assert_equal 13.5, expected
  # end

  def test_merchants_ranked_by_revenue_returns_the_merchants_ranked_by_total_revenue
    expected = @an.merchants_ranked_by_revenue
    assert_instance_of Merchant, expected.first
    assert_equal 12334634, expected.first.id
    assert_equal 12336175, expected.last.id
  end
end
