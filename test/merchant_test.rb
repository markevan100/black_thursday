require_relative 'test_helper'

class MerchantTest < Minitest::Test

  def setup
    @merchant = Merchant.new({
      id: 12334105,
      name: "Shopin1901",
      created_at: "2010-12-10",
      updated_at: "2011-12-04"
      })
  end

  def test_merchant_exists
    assert_instance_of Merchant, @merchant
  end

  def test_id_returns_merchant_id
    assert_equal 12334105, @merchant.id
  end
  
  def test_name_returns_name
    assert_equal "Shopin1901", @merchant.name
  end
end
