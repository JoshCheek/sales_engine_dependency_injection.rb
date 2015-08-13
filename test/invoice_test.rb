class InvoiceTest < Minitest::Test
  def test_customer_normalizes_its_attrs_when_set
    nil_cust = SalesEngine::Invoice.new

    raw_cust = SalesEngine::Invoice.new id:          '1',
                                        customer_id: '2',
                                        merchant_id: '3',
                                        status:      'shipped',
                                        created_at:  '2001-01-01 01:01:01 UTC',
                                        updated_at:  '2002-02-02 02:02:02 UTC'

    norm_cust = SalesEngine::Invoice.new id:          1,
                                         customer_id: 2,
                                         merchant_id: 3,
                                         status:      :shipped,
                                         created_at:  DateTime.new(2001, 1, 1, 1, 1, 1),
                                         updated_at:  DateTime.new(2002, 2, 2, 2, 2, 2)

    assert_equal       1, norm_cust.id
    assert_equal       1, raw_cust.id
    assert_equal     nil, nil_cust.id

    assert_equal       2, norm_cust.customer_id
    assert_equal       2, raw_cust.customer_id
    assert_equal     nil, nil_cust.customer_id

    assert_equal       3, norm_cust.merchant_id
    assert_equal       3, raw_cust.merchant_id
    assert_equal     nil, nil_cust.merchant_id

    assert_equal :shipped, norm_cust.status
    assert_equal :shipped, raw_cust.status
    assert_equal      nil, nil_cust.status

    assert_equal DateTime.new(2001, 1, 1, 1, 1, 1), norm_cust.created_at
    assert_equal DateTime.new(2001, 1, 1, 1, 1, 1), raw_cust.created_at
    assert_equal                               nil, nil_cust.created_at

    assert_equal DateTime.new(2002, 2, 2, 2, 2, 2), norm_cust.updated_at
    assert_equal DateTime.new(2002, 2, 2, 2, 2, 2), raw_cust.updated_at
    assert_equal                               nil, nil_cust.updated_at
  end
end
