require 'sqlite3'

class SalesEngine
  class SqliteDatabase
    attr_accessor :sqlite3

    def initialize(db_path)
      self.sqlite3 = SQLite3::Database.new(db_path)
    end

    def find_by(table, criteria)
      where_statements = criteria.keys.map { |column| "#{column} = (?)" }
      sql              = "SELECT * from #{table} where #{where_statements.join ' and '} LIMIT 1;"
      rows             = sqlite3.execute sql, *criteria.values
      row_hashes(table, rows).first
    end

    def find_all_by(table, criteria)
      where_statements = criteria.keys.map { |column| "#{column} = (?)" }
      sql              = "SELECT * from #{table} where #{where_statements.join ' and '};"
      rows             = sqlite3.execute sql, *criteria.values
      row_hashes table, rows
    end

    def random(table)
      rows = sqlite3.execute("SELECT * from #{table} ORDER BY random() LIMIT 1")
      row_hashes(table, rows).first
    end

    private

    def row_hashes(table, rows)
      rows.map { |values| columns_for(table).zip(values).to_h }
    end

    def columns_for(table)
      @columns_for        ||= {}
      @columns_for[table] ||= fetch_column_info_for(table)
    end

    def fetch_column_info_for(table)
      sqlite3.execute("PRAGMA table_info(#{table});").map { |_idk, name, *| name.intern }
    end
  end
end
