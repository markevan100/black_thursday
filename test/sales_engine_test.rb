require_relative 'test_helper'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
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
end
