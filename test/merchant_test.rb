require_relative 'test_helper'

class MerchantTest < Minitest::Test

  def setup
    @merchant = Merchant.new
    @new_respository = MerchantRepository.new
  end

  #These are tests for the merchant instance
  def test_merchant_exists
    assert_instance_of Merchant, @merchant
  end

  def test_merchant_is_a_hash
    @merchant[:id] = 123456
    assert_equal 123456, @merchant[:id]
  end

  #These are tests for the merchant_repository class
  def test_merchant_respository_exists
    assert_instance_of MerchantRepository, @new_respository
  end

  def test_merchant_respository_has_a_merchant_attribute
    assert_equal 12334105, @new_respository.merchants[0][:id]
  end

  #These test methods on the merchant_repository class
  def test_find_by_id
    one_merch = @new_respository.find_by_id(12336739)
    assert_equal "RanaParvaShop", one_merch[:name]
  end

  def test_find_by_name
    one_merch = @new_respository.find_by_name("RanaParvaShop")
    assert_equal 12336739, one_merch[:id]
  end

  def test_find_all_by_name
    assert_equal ["9LivesJewelry", "MarkThomasJewelry"], @new_respository.find_all_by_name("sJewelry")
  end

  def test_find_all_by_name_no_matches_returns_empty_array
    assert_equal [], @new_respository.find_all_by_name("thisdoesntexist")
  end

  def test_current_highest_id
    assert_equal 12337411, @new_respository.current_id_max
  end

  #These are tests for the create method of the merchant_repository class
  def test_create_creates_another_merchant_instance
    assert_equal 475, @new_respository.merchants.count
    @new_respository.create("Mark's Pinatas")
    assert_equal 476, @new_respository.merchants.count
  end

  def test_create_new_instance_can_be_found
    assert_equal [], @new_respository.find_all_by_name("MarksPinatas")
    @new_respository.create("MarksPinatas")
    one_merch = @new_respository.find_by_name("MarksPinatas")
    assert_equal 12337412, one_merch[:id]
  end




end
