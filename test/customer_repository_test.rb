require 'sales_engine'
require 'sales_engine/memory_database'

class CustomerRepositoryTest < Minitest::Test
  def engine
    @engine ||= (
      db     = SalesEngine::MemoryDatabase.new(
                 customers: [
                   {id: 1, first_name: "Josh", last_name: "Cheek" },
                   {id: 2, first_name: "Matt", last_name: "Hecker"},
                 ]
               )
      engine = SalesEngine::Base.new(db)
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

  def test_it_finds_random_records
    first_names = 100.times.map { engine.customer_repository.random.first_name }.uniq.sort
    assert_equal ["Josh", "Matt"], first_names

    # empty
    refute SalesEngine::Base.new(SalesEngine::MemoryDatabase.new).startup.customer_repository.random
  end
end
