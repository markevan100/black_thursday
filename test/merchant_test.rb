require_relative 'test_helper'

class MerchantTest < Minitest::Test

  def setup
    attributes = {
        id: 12334105,
        name: "Shopin1901",
        created_at: "2010-12-10",
        updated_at: "2011-12-04"
      }
    merchant = Merchant.new(attributes)
  end 

  def test_merchant_exists
    attributes = {
        id: 12334105,
        name: "Shopin1901",
        created_at: "2010-12-10",
        updated_at: "2011-12-04"
      }
    merchant = Merchant.new(attributes)
    assert_instance_of Merchant, merchant
  end

  def test_merchant_id
    attributes = {
        id: 12334105,
        name: "Shopin1901",
        created_at: "2010-12-10",
        updated_at: "2011-12-04"
      }
    merchant = Merchant.new(attributes)
    assert merchant.id
end
