require_relative 'test_helper'

class MerchantTest < Minitest::Test

  def setup
    attributes = {
        id: 12334105,
        name: "Shopin1901",
        created_at: "2010-12-10",
        updated_at: "2011-12-04"
      }
    @merchant = Merchant.new(attributes)
  end

  def test_merchant_exists
    assert_instance_of Merchant, @merchant
  end

  def test_merchant_id
    assert_equal 12334105, @merchant.id
  end
end
