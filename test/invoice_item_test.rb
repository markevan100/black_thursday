require_relative 'test_helper'

class InvoiceItemTest < Minitest::Test

  def setup
    attributes = {
        id: 2345,
        item_id: 263562118,
        invoice_id: 522,
        unit_price: 847.87,
        quantity: 7,
        created_at: "2012-03-27 14:54:35 UTC",
        updated_at: "2012-03-27 14:54:35 UTC"
      }
    @invoice_item = InvoiceItem.new(attributes)
  end

  def test_id_returns_the_invoice_item_id
    assert_equal 2345, @invoice_item.id
    assert_instance_of Integer, @invoice_item.id
  end

  def test_item_id_returns_the_item_id
    assert_equal 263562118, @invoice_item.item_id
    assert_instance_of Integer, @invoice_item.item_id
  end

  def test_invoice_id_returns_the_invoice_id
    assert_equal 522, @invoice_item.invoice_id
    assert_instance_of Integer, @invoice_item.invoice_id
  end

  def test_unit_price_returns_the_unit_price
    assert_equal 847.87, @invoice_item.unit_price
    assert_instance_of BigDecimal, @invoice_item.unit_price
  end

  def test_created_at_returns_a_Time_instance_for_the_date_the_invoice_item_was_created
    assert_equal Time.parse("2012-03-27 14:54:35 UTC"), @invoice_item.created_at
    assert_instance_of Time, @invoice_item.created_at
  end

  def test_updated_at_returns_a_Time_instance_for_the_date_the_invoice_item_was_last_updated
    assert_equal Time.parse("2012-03-27 14:54:35 UTC"), @invoice_item.updated_at
    assert_instance_of Time, @invoice_item.updated_at
  end
end
