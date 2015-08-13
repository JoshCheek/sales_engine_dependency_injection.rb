require 'sales_engine/transaction'

class TransactionTest < Minitest::Test
  def test_customer_normalizes_its_attrs_when_set
    db       = :not_a_db
    nil_cust = SalesEngine::Transaction.new db

    raw_cust = SalesEngine::Transaction.new db,
                                            id:                          '1',
                                            invoice_id:                  '2',
                                            credit_card_number:          '4654405418249632',
                                            credit_card_expiration_date: '2003-03-03 03:03:03 UTC',
                                            result:                      'success',
                                            created_at:                  '2001-01-01 01:01:01 UTC',
                                            updated_at:                  '2002-02-02 02:02:02 UTC'

    norm_cust = SalesEngine::Transaction.new db,
                                             id:                          1,
                                             invoice_id:                  2,
                                             credit_card_number:          '4654405418249632',
                                             credit_card_expiration_date: DateTime.new(2003, 3, 3, 3, 3, 3),
                                             result:                      :success,
                                             created_at:                  DateTime.new(2001, 1, 1, 1, 1, 1),
                                             updated_at:                  DateTime.new(2002, 2, 2, 2, 2, 2)

    assert_equal       1, norm_cust.id
    assert_equal       1, raw_cust.id
    assert_equal     nil, nil_cust.id

    assert_equal       2, norm_cust.invoice_id
    assert_equal       2, raw_cust.invoice_id
    assert_equal     nil, nil_cust.invoice_id

    assert_equal '4654405418249632', norm_cust.credit_card_number
    assert_equal '4654405418249632', raw_cust.credit_card_number
    assert_equal                nil, nil_cust.credit_card_number

    assert_equal DateTime.new(2003, 3, 3, 3, 3, 3), norm_cust.credit_card_expiration_date
    assert_equal DateTime.new(2003, 3, 3, 3, 3, 3), raw_cust.credit_card_expiration_date
    assert_equal                               nil, nil_cust.credit_card_expiration_date

    assert_equal :success, norm_cust.result
    assert_equal :success, raw_cust.result
    assert_equal      nil, nil_cust.result

    assert_equal DateTime.new(2001, 1, 1, 1, 1, 1), norm_cust.created_at
    assert_equal DateTime.new(2001, 1, 1, 1, 1, 1), raw_cust.created_at
    assert_equal                               nil, nil_cust.created_at

    assert_equal DateTime.new(2002, 2, 2, 2, 2, 2), norm_cust.updated_at
    assert_equal DateTime.new(2002, 2, 2, 2, 2, 2), raw_cust.updated_at
    assert_equal                               nil, nil_cust.updated_at
  end
end
