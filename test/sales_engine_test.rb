require 'sales_engine'
require 'sales_engine/sqlite_database'

class SalesEngineTest < Minitest::Test
  def csv_path
    File.expand_path "fixtures", __dir__
  end

  def test_acceptance
    engine = SalesEngine.new(csv_path)

    engine.startup

    customer = engine.customer_repository.find_by_first_name("Joey")
    assert_equal 1,          customer.id
    assert_equal "Joey",     customer.first_name
    assert_equal "Ondricka", customer.last_name

    customer = engine.customer_repository.find_by_first_name("Cecelia")
    assert_equal 2,         customer.id
    assert_equal "Cecelia", customer.first_name
    assert_equal "Osinski", customer.last_name
  end
end
