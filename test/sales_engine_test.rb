require_relative 'test_helper'

class SalesEngineTest < Minitest::Test
  
  def setup
    @se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
  end
  
  def test_it_exists  
    assert_instance_of SalesEngine, @se
  end
  
  def test_it_has_merchant_repository
    assert_instance_of MerchantRepository, @se.merchant_repository
  end
end
