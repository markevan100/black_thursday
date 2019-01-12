require_relative 'test_helper'

class InvoicesTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
  :invoices  => "./data/invoices.csv"
})
    @se = se.invoices
  end

  def test_all_returns_all_invoices
    binding.pry
    expected = @se.invoices.all
    assert_equal 4985, expected.length
  end
end


#
#   def setup
#     se = SalesEngine.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })
#     @new_repository = se.merchants
#   end
