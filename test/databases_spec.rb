require 'sales_engine'
require 'sales_engine/memory_database'

class CustomerRepositoryTest < Minitest::Test
  def db_path
    File.expand_path "fixtures/sales_engine.db", __dir__
  end

  def databases
    sqlite_db = SalesEngine::SqliteDatabase.new(db_path)
    memory_db = SalesEngine::MemoryDatabase.new \
      customers: [
        {id:  1, first_name: 'Joey',      last_name: 'Ondricka',  created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC'},
        {id:  2, first_name: 'Cecelia',   last_name: 'Osinski',   created_at: '2012-03-27 14:54:10 UTC', updated_at: '2012-03-27 14:54:10 UTC'},
        {id:  3, first_name: 'Mariah',    last_name: 'Toy',       created_at: '2012-03-27 14:54:10 UTC', updated_at: '2012-03-27 14:54:10 UTC'},
        {id:  4, first_name: 'Leanne',    last_name: 'Braun',     created_at: '2012-03-27 14:54:10 UTC', updated_at: '2012-03-27 14:54:10 UTC'},
        {id:  5, first_name: 'Sylvester', last_name: 'Nader',     created_at: '2012-03-27 14:54:10 UTC', updated_at: '2012-03-27 14:54:10 UTC'},
        {id:  6, first_name: 'Heber',     last_name: 'Kuhn',      created_at: '2012-03-27 14:54:10 UTC', updated_at: '2012-03-27 14:54:10 UTC'},
        {id:  7, first_name: 'Parker',    last_name: 'Daugherty', created_at: '2012-03-27 14:54:10 UTC', updated_at: '2012-03-27 14:54:10 UTC'},
        {id:  8, first_name: 'Loyal',     last_name: 'Considine', created_at: '2012-03-27 14:54:11 UTC', updated_at: '2012-03-27 14:54:11 UTC'},
        {id:  9, first_name: 'Dejon',     last_name: 'Fadel',     created_at: '2012-03-27 14:54:11 UTC', updated_at: '2012-03-27 14:54:11 UTC'},
        {id: 10, first_name: 'Ramona',    last_name: 'Reynolds',  created_at: '2012-03-27 14:54:11 UTC', updated_at: '2012-03-27 14:54:11 UTC'},
      ]

    [sqlite_db, memory_db]
  end

  def test_it_finds_records_by_an_attribute_and_table
    databases.each do |database|
      assert_equal   1, database.find_by(:customers, id:  1).first
      assert_equal   2, database.find_by(:customers, id:  2).first
      assert_equal nil, database.find_by(:customers, id: -1)
    end
  end

  def test_it_can_choose_a_random_record
    databases.each do |database|
      # random
      assert 1 < 10.times.map { database.random :customers }.uniq.length

      # format
      assert_equal Fixnum, database.random(:customers)[0].class
    end
  end
end
