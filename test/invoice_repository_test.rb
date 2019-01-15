require_relative 'test_helper'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :invoices => "./data/invoices.csv",
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoice_items => "./data/invoice_items.csv",
    })
    @new_repository = se.invoices
  end

  def test_all_returns_all_invoices
    expected = @new_repository.all
    assert_equal 4985, expected.length
  end

  def test_find_by_id_returns_an_invoice_associated_to_the_given_id
    invoice_id = 3452
    expected = @new_repository.find_by_id(invoice_id)

    assert_equal invoice_id, expected.id
    assert_equal 12335690, expected.merchant_id
    assert_equal 679, expected.customer_id
    assert_equal :pending, expected.status

    invoice_id = 5000
    expected = @new_repository.find_by_id(invoice_id)

    assert_nil expected
  end

  def test_find_all_by_customer_id_returns_all_invoices_associated_with_given_customer
    customer_id = 300
    expected = @new_repository.find_all_by_customer_id(customer_id)

    assert_equal 10, expected.length

    customer_id = 1000
    expected = @new_repository.find_all_by_customer_id(customer_id)

    assert_equal [], expected
  end

  def test_find_all_by_merchant_id_returns_all_invoices_associated_with_given_merchant
    merchant_id = 12335080
    expected = @new_repository.find_all_by_merchant_id(merchant_id)

    assert_equal 7, expected.length

    merchant_id = 1000
    expected = @new_repository.find_all_by_merchant_id(merchant_id)

    assert_equal [], expected
  end

  def test_find_all_by_status_returns_all_invoices_associated_with_given_status
    status = :shipped
    expected = @new_repository.find_all_by_status(status)

    assert_equal 2839, expected.length

    status = :pending
    expected = @new_repository.find_all_by_status(status)

    assert_equal 1473, expected.length

    status = :sold
    expected = @new_repository.find_all_by_status(status)

    assert_equal [], expected
  end

  def test_create_creates_a_new_invoice_instance
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }
    @new_repository.create(attributes)
    expected = @new_repository.find_by_id(4986)
    assert_equal 8, expected.merchant_id
  end

  def test_update_updates_an_invoice
    attributes = {
      status: :success
    }
    @new_repository.update(4985, attributes)
    expected = @new_repository.find_by_id(4985)
    assert_equal :success, expected.status
    assert_equal 999, expected.customer_id
  end

  def test_update_on_unknown_invoice_does_nothing
    @new_repository.update(5000, {})
  end

  def test_delete_deletes_the_specified_invoice
    @new_repository.delete(4986)
    expected = @new_repository.find_by_id(4986)
    assert_nil expected
  end

  def test_delete_on_unknown_invoice_does_nothing
    @new_repository.delete(5000)
  end
end
