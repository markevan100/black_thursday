require_relative 'test_helper'

class MerchantTest < Minitest::Test

  def test_merchant_exists
    merchant = Merchant.new
    assert_instance_of Merchant, merchant
  end

  def test_merchant_is_a_hash
    merchant = Merchant.new
    merchant[:id] = 123456
    assert_equal 123456, merchant[:id]
  end 
end
