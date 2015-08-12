class SalesEngine

  require 'sqlite3'
  class SqliteDatabase
    def initialize(db_path)
      self.sqlite3 = SQLite3::Database.new(db_path)
    end

    def find_by(table, criteria)
      where_statements = criteria.keys.map { |column| "#{column} = (?)" }
      sql              = "SELECT * from #{table} where #{where_statements.join ' and '} LIMIT 1;"
      rows             = sqlite3.execute sql, *criteria.values
      rows.first
    end

    private

    attr_accessor :sqlite3
  end

  class MemoryDatabase
    def initialize(table_data)
      self.table_data = table_data
    end

    def find_by(table, criteria)
      row = table_data[table].find do |row|
        criteria.all? do |attribute, value|
          row.fetch(attribute) == value
        end
      end
      row.values if row
    end

    private

    attr_accessor :table_data
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

    def find_by_id(id)
      find_by id: id
    end

    def find_by_last_name(last_name)
      find_by last_name: last_name
    end

    def find_by(critieria)
      row = db.find_by(:customers, critieria)
      Customer.new *row if row
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
