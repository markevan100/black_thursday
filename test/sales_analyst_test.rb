require_relative 'test_helper'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
  end

  def test_average_items_per_merchant
    expected = @se.analyst.average_items_per_merchant
    assert_equal 2.88, expected
    assert_instance_of Float, expected
  end

  def test_average_items_per_merchant_standard_deviation
    expected = @se.analyst.average_items_per_merchant_standard_deviation
    assert_equal 3.26, expected
    assert_instance_of Float, expected
  end

  def test_merchants_with_high_item_count_returns_merchants_more_than_one_standard_deviation
    expected = @se.analyst.merchants_with_high_item_count
    assert_equal 52, expected.length
    assert_instance_of Merchant, expected.first
  end

  def test_average_item_price_for_merchant_returns_the_average_item_price
      merchant_id = 12334105
      expected = @se.analyst.average_item_price_for_merchant(merchant_id)

      assert_equal 16.66, expected
      assert_instance_of BigDecimal, expected
    end

    def test_it_average_average_price_per_merchant_returns_the_average_price_for_all_merchants
      expected = @se.analyst.average_average_price_per_merchant

      assert_equal 350.29, expected
      assert_instance_of BigDecimal, expected
    end

    def test_golden_items_returns_items_that_are_two_standard_deviations_above_the_average_price
    expected = @se.analyst.golden_items

    assert_equal 5, expected.length
    assert_instance_of Item, expected.first
    end
end
