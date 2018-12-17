require_relative 'test_helper'

class ItemTest < Minitest::Test

  def setup
    @item = Item.new
    @new_repository = ItemRepository.new
  end

  def test_item_exists
    assert_instance_of Item, @item
  end

  def test_item_new_item
    new_item = Item.new
    assert_instance_of Item, new_item
  end

  def test_item_is_a_hash
    @item[:id] = 123456
    assert_equal 123456, @item[:id]
  end

  #These are tests for the item_repository class
  def test_item_respository_exists
    assert_instance_of ItemRepository, @new_repository
  end

  def test_item_respository_has_a_item_attribute
    assert_equal 263395237, @new_repository.items[0][:id]
  end

  #These test find methods on the merchant_repository class
  def test_find_by_id
    one_item = @new_repository.find_by_id(263401265)
    assert_equal "Oak Bowl", one_item[:name]
  end
  #
  def test_find_by_name
    one_item = @new_repository.find_by_name("Oak Bowl")
    assert_equal 263401265, one_item[:id]
  end
  #
  def test_find_all_by_name
    assert_equal ["Spalted Sycamore Bowl", "Field Maple Bowl"], @new_repository.find_all_by_name("e Bowl")
  end
  #
  def test_find_all_by_name_no_matches_returns_empty_array
    assert_equal [], @new_repository.find_all_by_name("thisdoesntexist")
  end
  #
  # #These are tests for manipulating item instances of the item_repository class
  def test_current_highest_id
    assert_equal 263567474, @new_repository.current_id_max
  end
  #
  def test_create_creates_another_item_instance
    assert_equal 1367, @new_repository.items.count
    @new_repository.create("Pinata", "A Pinata!", 1500, 12345678)
    assert_equal 1368, @new_repository.items.count
  end
  #
  def test_create_new_instance_can_be_found
    assert_equal [], @new_repository.find_all_by_name("Pinata")
    @new_repository.create("Pinata", "A Pinata!", 1500, 12345678)
    one_item = @new_repository.find_by_name("Pinata")
    assert_equal 263567475, one_item[:id]
  end
  #
  def test_update_changes_name
    @new_repository.create("Pinata", "A Pinata!", 1500, 12345678)
    one_item = @new_repository.find_by_name("Pinata")
    assert_equal 263567475, one_item[:id]
    @new_repository.update(263567475, "Pinata Ornament", "A Christmas Pinata!", 2000, 12345678)
    update_item = @new_repository.find_by_name("Pinata Ornament")
    assert_equal 263567475, update_item[:id]
    assert_nil @new_repository.find_by_name("Pinata")
  end
  #
  def test_delete_an_instance_of_a_item_by_id
    @new_repository.create("Pinata", "A Pinata!", 1500, 12345678)
    one_item = @new_repository.find_by_name("Pinata")
    assert_equal 263567475, one_item[:id]
    @new_repository.delete(263567475)
    assert_nil @new_repository.find_by_name("Pinata")
  end
end
