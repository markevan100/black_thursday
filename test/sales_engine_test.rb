require_relative 'test_helper'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
  end

  def test_sales_engine_has_merchant_repo
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_merchant_repository_stays_the_same
    object_id = @se.merchants.object_id
    assert_equal object_id, @se.merchants.object_id
  end

  def test_sales_engine_has_item_repo
    assert_instance_of ItemRepository, @se.items
  end

  def test_item_repository_stays_the_same
    object_id = @se.items.object_id
    assert_equal object_id, @se.items.object_id
  end

  def test_analyst_exists
    analyst = @se.analyst
    assert_instance_of SalesAnalyst, analyst
  end

  #SalesAnalyst tests
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
    #assert_instance_of Merchant, expected.first.class
  end
end
