require_relative 'test_helper'

class MerchantRepositoryTest < Minitest::Test

  def setup
      se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv",
  })
    @new_repository = se.merchants
  end

  def test_merchant_respository_exists
    assert_instance_of MerchantRepository, @new_repository
  end

  def test_merchant_respository_has_a_merchant_attribute
    assert_equal Array, @new_repository.merchants.class
  end

  def test_merchant_repository_has_merchants
    assert_equal 475, @new_repository.merchants.count
  end

  #These test find methods on the merchant_repository class
  def test_find_by_id
    one_merch = @new_repository.find_by_id(12336739)
    assert_equal "RanaParvaShop", one_merch.name
  end

  def test_find_by_name
    one_merch = @new_repository.find_by_name("RanaParvaShop")
    assert_equal 12336739, one_merch.id
  end

  def test_find_all_by_name
    array = @new_repository.find_all_by_name("sJewelry")
    new_array = []
    new_array << array[0].name
    new_array << array[1].name
    assert_equal ["9LivesJewelry", "MarkThomasJewelry"], new_array
  end

  def test_find_all_by_name_no_matches_returns_empty_array
    assert_equal [], @new_repository.find_all_by_name("thisdoesntexist")
  end

  # #These are tests for manipulating merchant instances of the merchant_repository class
  def test_current_highest_id
    assert_equal 12337411, @new_repository.current_id_max
  end

  def test_create_creates_another_merchant_instance
    attributes = {
        name: "Turing School of Software and Design"
      }
    assert_equal 475, @new_repository.merchants.count
    @new_repository.create(attributes)
    assert_equal 476, @new_repository.merchants.count
    one_merch = @new_repository.find_by_name("Turing School of Software and Design")
    assert_equal 12337412, one_merch.id
  end
end
