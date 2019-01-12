require_relative 'test_helper'

class ItemRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
    @new_repository = se.items
  end

  def test_item_respository_exists
    assert_instance_of ItemRepository, @new_repository
  end

  def test_item_respository_has_a_item_attribute
    assert_equal 263395237, @new_repository.items[0].id
  end

  def test_find_by_id
    one_item = @new_repository.find_by_id(263401265)
    assert_equal "Oak Bowl", one_item.name
  end

  def test_find_by_name
    one_item = @new_repository.find_by_name("Oak Bowl")
    assert_equal 263401265, one_item.id
  end

  def test_find_all_with_description
    description = "A large Yeti of sorts, casually devours a cow as the others watch numbly."
    expected = @new_repository.find_all_with_description(description)

    assert_equal description, expected.first.description
    assert_equal 263550472, expected.first.id

    description = "A LARGE yeti of SOrtS, casually devoURS a COw as the OTHERS WaTch NUmbly."
    expected = @new_repository.find_all_with_description(description)

    assert_equal 263550472, expected.first.id

    description = "Sales Engine is a relational database"
    expected = @new_repository.find_all_with_description(description)

    assert_equal 0, expected.length
  end

  def test_find_all_by_price
    price = BigDecimal.new(25)
    expected = @new_repository.find_all_by_price(price)

    assert_equal 79, expected.length
  end

  def test_find_all_by_price_in_range
    range = (1000.00..1500.00)
    expected = @new_repository.find_all_by_price_in_range(range)

    assert_equal 19, expected.length
  end

  def test_find_all_by_merchant_id
    merchant_id = 12334326
    expected = @new_repository.find_all_by_merchant_id(merchant_id)

    assert_equal 6, expected.length
  end

   #These are tests for manipulating or creating item instances of the item_repository class
  def test_current_highest_id
    assert_equal 263567474, @new_repository.current_id_max
  end

  def test_create_creates_another_item_instance
    attributes = {
        name: "Capita Defenders of Awesome 2018",
        description: "This board both rips and shreds",
        unit_price: BigDecimal.new(399.99, 5),
        created_at: Time.now,
        updated_at: Time.now,
        merchant_id: 25
      }
    @new_repository.create(attributes)
    expected = @new_repository.find_by_id(263567475)
    assert_equal "Capita Defenders of Awesome 2018", expected.name
  end

  def test_delete_deletes_the_specified_item
    @new_repository.delete(263567475)
    expected = @new_repository.find_by_id(263567475)
    assert_nil expected
  end
end
