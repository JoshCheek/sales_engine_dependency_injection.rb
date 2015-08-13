class CustomerTest < Minitest::Test
  def test_customer_normalizes_its_attrs_when_set
    nil_cust = SalesEngine::Customer.new

    raw_cust = SalesEngine::Customer.new id:         '1',
                                         first_name: 'Josh',
                                         last_name:  'Cheek',
                                         created_at: '2001-01-01 01:01:01 UTC',
                                         updated_at: '2002-02-02 02:02:02 UTC'

    norm_cust = SalesEngine::Customer.new id:         1,
                                          first_name: 'Josh',
                                          last_name:  'Cheek',
                                          created_at: DateTime.new(2001, 1, 1, 1, 1, 1),
                                          updated_at: DateTime.new(2002, 2, 2, 2, 2, 2)

    assert_equal       1, norm_cust.id
    assert_equal       1, raw_cust.id
    assert_equal     nil, nil_cust.id

    assert_equal  'Josh', norm_cust.first_name
    assert_equal  'Josh', raw_cust.first_name
    assert_equal     nil, nil_cust.first_name

    assert_equal 'Cheek', norm_cust.last_name
    assert_equal 'Cheek', raw_cust.last_name
    assert_equal     nil, nil_cust.last_name

    assert_equal DateTime.new(2001, 1, 1, 1, 1, 1), norm_cust.created_at
    assert_equal DateTime.new(2001, 1, 1, 1, 1, 1), raw_cust.created_at
    assert_equal                               nil, nil_cust.created_at

    assert_equal DateTime.new(2002, 2, 2, 2, 2, 2), norm_cust.updated_at
    assert_equal DateTime.new(2002, 2, 2, 2, 2, 2), raw_cust.updated_at
    assert_equal                               nil, nil_cust.updated_at
  end
end
