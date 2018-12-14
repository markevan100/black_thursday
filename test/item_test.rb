require_relative 'test_helper'

class ItemTest < Minitest::Test

  def setup
    @item = Item.new
  end

  def test_item_exists
    assert_instance_of Item, @item
  end

end
