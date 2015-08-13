require 'sales_engine/base'

class SalesEngine < SalesEngine::Base
  attr_accessor :csv_path

  def initialize(csv_path)
    self.csv_path = csv_path
  end

  def startup
    require 'csv'
    require 'sales_engine/sqlite_database'

    self.db = SqliteDatabase.new(':memory:')
    db.sqlite3.execute '
      CREATE TABLE customers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        first_name VARCHAR(50),
        last_name VARCHAR(50)
      )
    '

    customers_csv = File.join csv_path, 'customers.csv'

    rows = CSV.foreach(customers_csv, headers: true).map do |row|
      [ row['id'].to_i,
        row['first_name'],
        row['last_name']
      ]
    end

    rows.each_slice 500 do |slice|
      escaped_row    = '(' << (slice.first||[]).map { '?' }.join(',') << ')'
      escaped_values = slice.map { escaped_row }.join(',')
      sql            = "INSERT INTO customers (id, first_name, last_name) VALUES #{escaped_values};"
      db.sqlite3.execute sql, slice
    end

    super
  end
end
