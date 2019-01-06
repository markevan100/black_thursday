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
end




# def test_from_csv_sets_a_hash
#   se = SalesEngine.new
#   se.from_csv({:items => "one item"})
#   assert_equal "one item", se[:items]
# end


  # def test_sales_engine_exists
  #   se = SalesEngine.new
  #   assert_instance_of SalesEngine, se
  # end
