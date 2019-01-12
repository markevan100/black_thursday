require_relative 'test_helper'

class ItemTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
  :items     => './data/items.csv',
  :merchants => './data/merchants.csv',
})
    #@item = Item.new
    @new_repository = se.items
  end

  def test_id_returns_the_id
    item_one = @new_repository.all.first
    assert_equal 263395237, item_one.id

    item_two = @new_repository.all.last
    assert_equal item_two.id, 263567474
  end

  def name_returns_the_name
    item_one = @new_repository.all.first
    assert_equal "510+ RealPush Icon Set", item_one.name

    item_two = @new_repository.all.last
    assert_equal "Minty Green Knit Crochet Infinity Scarf", item_two.name
  end

  def test_description_returns_the_description
    item_one = @new_repository.all.first

    assert_equal String, item_one.description.class
    assert_equal 2237, item_one.description.length
  end

  def test_unit_price_returns_the_unit_price
    item_one = @new_repository.all.first

    assert_equal 12.00, item_one.unit_price
    assert_equal BigDecimal, item_one.unit_price.class
  end

  def created_at_returns_the_Time_the_item_was_created
    item_one = @new_repository.all.first
    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), item_one.created_at
    assert_equal Time, item_one.created_at.class
  end

  def test_updated_at_returns_the_Time_the_item_was_last_updated
    item_one = @new_repository.all.first

    assert_equal Time.parse("2007-06-04 21:35:10 UTC"), item_one.updated_at
    assert_equal Time, item_one.updated_at.class
  end

  def test_unit_price_to_dollars_returns_price_as_Float
    expected = @new_repository.find_by_id(263397059)
    assert_equal 130.0, expected.unit_price_to_dollars
    assert_equal Float, expected.unit_price_to_dollars.class
  end
end
