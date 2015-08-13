require 'sales_engine'
require 'sales_engine/memory_database'

module RepoHelpers
  def table_name
    raise NotImplementedError, "Subclasses must implement this method"
  end

  def engine_for(table_data)
    db = SalesEngine::MemoryDatabase.new(table_data)
    SalesEngine::Base.new(db).startup
  end

  def repo_for(*customer_data)
    engine_for(table_name => customer_data).customer_repository
  end
end
