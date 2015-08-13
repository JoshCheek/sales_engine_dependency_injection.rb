require 'sqlite3'

class SalesEngine
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
end
