require_relative 'test_helper'

class InvoiceRepositoryTest < Minitest::Test
  include RepoHelpers

  def table_name
    :invoices
  end

  def test_it_can_find_records_by_their_id
    repo = repo_for({id: 1, status: 'shipped'},
                    {id: 2, status: 'not_shipped'})
    assert_equal :shipped,     repo.find_by_id(1).status
    assert_equal :not_shipped, repo.find_by_id(2).status
  end
end
