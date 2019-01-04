require_relative 'test_helper'

class MerchantTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
      @mr = se.merchant_repository
  end
  
  def test_merchant_respository_exists
    assert_instance_of MerchantRepository, @mr
  end
  
  def test_merchant_repo_has_merchants
    assert_instance_of Merchant, @mr.merchants.first
  end

  def test_merchant_respository_has_a_merchant_attribute
    assert_equal 12334105, @mr.merchants.first.id
  end

  def test_find_by_id
    merchant = @mr.find_by_id(12336739)
    assert_equal "RanaParvaShop", merchant.name
  end
  # 
  # def test_find_by_name
  #   one_merch = @new_repository.find_by_name("RanaParvaShop")
  #   assert_equal 12336739, one_merch[:id]
  # end
  # 
  # def test_find_all_by_name
  #   assert_equal ["9LivesJewelry", "MarkThomasJewelry"], @new_repository.find_all_by_name("sJewelry")
  # end
  # 
  # def test_find_all_by_name_no_matches_returns_empty_array
  #   assert_equal [], @new_repository.find_all_by_name("thisdoesntexist")
  # end
  # 
  # #These are tests for manipulating merchant instances of the merchant_repository class
  # def test_current_highest_id
  #   assert_equal 12337411, @new_repository.current_id_max
  # end
  # 
  # def test_create_creates_another_merchant_instance
  #   assert_equal 475, @new_repository.merchants.count
  #   @new_repository.create("Mark's Pinatas")
  #   assert_equal 476, @new_repository.merchants.count
  # end
  # 
  # def test_create_new_instance_can_be_found_xx
  #   assert_equal [], @new_repository.find_all_by_name("MarksPinatas")
  #   require "pry"; binding.pry
  #   @new_repository.create("MarksPinatas")
  #   one_merch = @new_repository.find_by_name("MarksPinatas")
  #   assert_equal 12337412, one_merch[:id]
  # end
  # 
  # def test_update_changes_name
  #   @new_repository.create("MarksPinatas")
  #   one_merch = @new_repository.find_by_name("MarksPinatas")
  #   assert_equal 12337412, one_merch[:id]
  #   @new_repository.update(12337412, "MartysPinatas")
  #   update_merch = @new_repository.find_by_name("MartysPinatas")
  #   assert_equal 12337412, one_merch[:id]
  # end
  # 
  # def test_delete_an_instance_of_a_merchant_by_id
  #   @new_repository.create("MarksPinatas")
  #   one_merch = @new_repository.find_by_name("MarksPinatas")
  #   assert_equal 12337412, one_merch[:id]
  #   @new_repository.delete(12337412)
  #   assert_nil @new_repository.find_by_name("MarksPinatas")
  # end
  # 
end