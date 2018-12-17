require_relative 'test_helper'

class SalesEngineTest < Minitest::Test

  def test_from_csv_sets_a_hash
    se = SalesEngine.from_csv({:items => "one item"})
    assert_equal "one item", se[:items]
  end

  def test_from_csv_can_find_an_item_in_a_hash
    se = SalesEngine.from_csv({
      :items => "one item",
      :things => "one thing",
      :lists => "one list"
      })
    assert_equal "one list", se[:lists]
  end
end




# def test_from_csv_sets_a_hash
#   se = SalesEngine.new
#   se.from_csv({:items => "one item"})
#   assert_equal "one item", se[:items]
# end


  # def test_sales_engine_exists
  #   se = SalesEngine.new
  #   assert_instance_of SalesEngine, se
  # end
