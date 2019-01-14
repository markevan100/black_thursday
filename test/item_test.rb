require_relative 'test_helper'

class ItemTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
    :items     => './data/items.csv',
    :merchants => './data/merchants.csv',
    :invoices => './data/invoices.csv',
  }) 
    @new_repository = se.items
  end

  def test_id_returns_the_id
    item_one = @new_repository.all.first
    assert_equal 263395237, item_one.id

    item_two = @new_repository.all.last
    assert_equal 263567474, item_two.id
  end

  def test_unit_price_returns_the_unit_price
    item_one = @new_repository.all.first

    assert_equal 12.00, item_one.unit_price
    assert_instance_of BigDecimal, item_one.unit_price
  end
end
