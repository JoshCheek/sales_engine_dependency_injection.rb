require_relative 'test_helper'

class TransactionRepositoryTest < Minitest::Test
  include RepoHelpers

  def table_name
    :transactions
  end

  def test_it_can_find_records_by_their_id
    repo = repo_for({id: 1, credit_card_number: '111'},
                    {id: 2, credit_card_number: '222'})
    assert_equal '111', repo.find_by_id(1).credit_card_number
    assert_equal '222', repo.find_by_id(2).credit_card_number
  end
end
