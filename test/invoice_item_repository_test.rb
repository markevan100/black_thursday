require_relative 'test_helper'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :invoices => "./data/invoices.csv",
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv",
    })
    @se = se.invoice_items
  end

  def test_all_returns_an_array_of_all_invoice_item_instances
    expected = @se.all
    assert_equal 21830, expected.count
  end

  def test_find_by_id_finds_an_invoice_item_by_id
    id = 10
    expected = @se.find_by_id(id)

    assert_equal id, expected.id
    assert_equal 263523644, expected.item_id
    assert_equal 2, expected.invoice_id
  end

  def test_find_by_id_returns_nil_if_the_invoice_item_does_not_exist
    id = 200000
    expected = @se.find_by_id(id)

    assert_nil expected
  end

  def test_find_all_by_item_id_finds_all_items_matching_given_item_id
    item_id = 263408101
    expected = @se.find_all_by_item_id(item_id)

    assert_equal 11, expected.length
    assert_instance_of InvoiceItem, expected.first
  end

  def test_find_all_by_item_id_returns_an_empty_array_if_there_are_no_matches
    item_id = 10
    expected = @se.find_all_by_item_id(item_id)

    assert_equal 0, expected.length
    assert expected.empty?
  end

  def test_find_all_by_invoice_id_finds_all_items_matching_given_item_id
   invoice_id = 100
    expected = @se.find_all_by_invoice_id(invoice_id)

    assert_equal 3, expected.length
    assert_instance_of InvoiceItem, expected.first
  end

  def test_find_all_by_invoice_id_returns_an_empty_array_if_there_are_no_matches
    invoice_id = 1234567890
    expected = @se.find_all_by_invoice_id(invoice_id)

    assert_equal 0, expected.length
    assert expected.empty?
  end

  def test_create_creates_a_new_invoice_item_instance
    attributes = {
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }
    @se.create(attributes)
    expected = @se.find_by_id(21831)
    assert_equal 7, expected.item_id
  end

  def test_update_updates_an_invoice_item
    attributes = {
      quantity: 13
    }
    @se.update(21830, attributes)
    expected = @se.find_by_id(21830)
    assert_equal 13, expected.quantity
    assert_equal 263519844, expected.item_id
  end

  def test_delete_deletes_the_specified_invoice
    @se.delete(21830)
    expected = @se.find_by_id(21830)
    assert_nil expected
  end
end
