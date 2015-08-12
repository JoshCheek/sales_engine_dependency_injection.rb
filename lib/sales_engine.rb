class SalesEngine

  require 'sqlite3'
  class SqliteDatabase
    attr_accessor :db
    def initialize(db_path)
      self.db = SQLite3::Database.new(db_path)
    end

    def find_by(table, criteria)
      where_statements = criteria.keys.map { |column| "#{column} = (?)" }
      sql              = "SELECT * from #{table} where #{where_statements.join ' and '} LIMIT 1;"
      rows             = db.execute sql, *criteria.values
      rows.first
    end
  end

  class Customer
    attr_accessor :id, :first_name, :last_name
    def initialize(id, first_name, last_name)
      self.id         = id
      self.first_name = first_name
      self.last_name  = last_name
    end
  end

  class CustomerRepository
    attr_accessor :db
    def initialize(db)
      self.db = db
    end

    def find_by_first_name(first_name)
      find_by first_name: first_name
    end

    def find_by(critieria)
      row = db.find_by(:customers, critieria)
      Customer.new(*row)
    end
  end

  attr_accessor :db, :customer_repository

  def initialize(db)
    self.db = db
  end

  def startup
    self.customer_repository = CustomerRepository.new(db)
  end
end
