require_relative 'test_helper'

class AssociationsTest < Minitest::Test
  include RepoHelpers

  def test_customers_and_invoices
    engine = engine_for customers: [{id: 1}, {id: 2}],
                        invoices:  [{id: 11, customer_id: 1}, {id: 22, customer_id: 2}]

    cust1 = engine.customer_repository.find_by_id 1
    cust2 = engine.customer_repository.find_by_id 2

    assert_equal [11], cust1.invoices.map(&:id)
    assert_equal [22], cust2.invoices.map(&:id)

    assert_equal 1, cust1.invoices.first.customer.id
    assert_equal 2, cust2.invoices.first.customer.id
  end
end
