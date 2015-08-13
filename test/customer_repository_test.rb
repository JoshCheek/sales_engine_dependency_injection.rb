require_relative 'test_helper'

class CustomerRepositoryTest < Minitest::Test
  include RepoHelpers

  def table_name
    :customers
  end

  def josh_created_at() Time.new 2001, 01, 01, 01, 01, 01 end
  def josh_updated_at() Time.new 2002, 02, 02, 02, 02, 02 end
  def matt_created_at() Time.new 2003, 03, 03, 03, 03, 03 end
  def matt_updated_at() Time.new 2004, 04, 04, 04, 04, 04 end

  def repo1
    @engine1 ||= repo_for(
      {id: 1, first_name: "Josh", last_name: "Cheek" , created_at: josh_created_at, updated_at: josh_updated_at},
      {id: 2, first_name: "Matt", last_name: "Hecker", created_at: matt_created_at, updated_at: matt_updated_at},
    )
  end

  def test_it_finds_by_id
    assert_equal "Josh", repo1.find_by_id(1).first_name
    assert_equal "Matt", repo1.find_by_id(2).first_name
    refute               repo1.find_by_id(3)
  end

  def test_it_finds_by_first_name
    assert_equal "Josh", repo1.find_by_first_name("Josh").first_name
    assert_equal "Matt", repo1.find_by_first_name("Matt").first_name
    refute               repo1.find_by_first_name("Carl")
  end

  def test_it_finds_by_last_name
    assert_equal "Josh", repo1.find_by_last_name("Cheek" ).first_name
    assert_equal "Matt", repo1.find_by_last_name("Hecker").first_name
    refute               repo1.find_by_last_name("lkj"   )
  end

  def test_it_finds_by_created_at
    assert_equal "Josh", repo1.find_by_created_at(josh_created_at).first_name
    assert_equal "Matt", repo1.find_by_created_at(matt_created_at).first_name
    refute               repo1.find_by_created_at(Time.now)
  end

  def test_it_finds_by_updated_at
    assert_equal "Josh", repo1.find_by_updated_at(josh_updated_at).first_name
    assert_equal "Matt", repo1.find_by_updated_at(matt_updated_at).first_name
    refute               repo1.find_by_updated_at(Time.now)
  end

  def test_it_finds_random_records
    first_names = 100.times.map { repo1.random.first_name }.uniq.sort
    assert_equal ["Josh", "Matt"], first_names

    # empty
    refute repo_for().random
  end

  def test_it_finds_all_by_first_name
    repo = repo_for({id: 1, first_name: 'Josh'},
                    {id: 2, first_name: 'Sara'},
                    {id: 3, first_name: 'Josh'},
                   )

    assert_equal [1, 3], repo.find_all_by_first_name("Josh").map(&:id)
    assert_equal [2],    repo.find_all_by_first_name("Sara").map(&:id)
    assert_equal [],     repo.find_all_by_first_name("lkj" ).map(&:id)
  end
end
