require 'sales_engine'

class CustomerRepositoryTest < Minitest::Test
  def engine
    @engine ||= (
      db     = SalesEngine::MemoryDatabase.new(
                 customers: [
                   {id: 1, first_name: "Josh", last_name: "Cheek" },
                   {id: 2, first_name: "Matt", last_name: "Hecker"},
                 ]
               )
      engine = SalesEngine.new(db)
      engine.startup
      engine
    )
  end

  def test_it_finds_by_id
    assert_equal "Josh", engine.customer_repository.find_by_id(1).first_name
    assert_equal "Matt", engine.customer_repository.find_by_id(2).first_name
    refute               engine.customer_repository.find_by_id(3)
  end

  def test_it_finds_by_first_name
    assert_equal "Josh", engine.customer_repository.find_by_first_name("Josh").first_name
    assert_equal "Matt", engine.customer_repository.find_by_first_name("Matt").first_name
    refute               engine.customer_repository.find_by_first_name("Carl")
  end

  def test_it_finds_by_last_name
    assert_equal "Josh", engine.customer_repository.find_by_last_name("Cheek" ).first_name
    assert_equal "Matt", engine.customer_repository.find_by_last_name("Hecker").first_name
    refute               engine.customer_repository.find_by_last_name("lkj"   )
  end
end