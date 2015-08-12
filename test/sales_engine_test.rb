require 'sales_engine'

class SalesEngineTest < Minitest::Test
  def db_path
    File.expand_path "fixtures/sales_engine.db", __dir__
  end

  def test_acceptance
    db     = SalesEngine::SqliteDatabase.new(db_path)
    engine = SalesEngine.new(db)

    engine.startup

    customer = engine.customer_repository.find_by_first_name("Josh")
    assert_equal 1,       customer.id
    assert_equal "Josh",  customer.first_name
    assert_equal "Cheek", customer.last_name

    customer = engine.customer_repository.find_by_first_name("Matt")
    assert_equal 2,        customer.id
    assert_equal "Matt",   customer.first_name
    assert_equal "Hecker", customer.last_name
  end
end
