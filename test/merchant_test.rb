require_relative 'test_helper'

class MerchantTest < Minitest::Test

  #These are tests for the merchant instance
  def test_merchant_exists
    merchant = Merchant.new
    assert_instance_of Merchant, merchant
  end

  def test_merchant_is_a_hash
    merchant = Merchant.new
    merchant[:id] = 123456
    assert_equal 123456, merchant[:id]
  end

  #These are tests for the merchant_repository class
  def test_merchant_respository_exists
    merchants = MerchantRepository.new
    assert_instance_of MerchantRepository, merchants
  end

  def test_merchant_respository_has_a_merchant_attribute
    new_respository = MerchantRepository.new
    assert_equal 12334105, new_respository.merchants[0][:id]
  end
end
