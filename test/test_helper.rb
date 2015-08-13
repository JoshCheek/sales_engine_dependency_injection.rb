require 'fileutils'

fixture_db = File.expand_path "fixtures/sales_engine.db", __dir__

unless File.exist? fixture_db
  FileUtils.mkdir_p File.dirname(fixture_db)

  require 'sqlite3'
  db = SQLite3::Database.new(fixture_db)
  db.execute '
    CREATE TABLE customers (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      first_name VARCHAR(50),
      last_name VARCHAR(50)
    )
  '

  require 'csv'
  csv_path = "/Users/josh/deleteme/sales_engines/sales_engine_spec_harness/data/customers.csv"
  rows = CSV.foreach(csv_path, headers: true).map do |row|
    [ row['id'].to_i,
      row['first_name'],
      row['last_name']
    ]
  end

  rows.each_slice 500 do |slice|
    escaped_row    = '(' << (slice.first||[]).map { '?' }.join(',') << ')'
    escaped_values = slice.map { escaped_row }.join(',')
    sql            = "INSERT INTO customers (id, first_name, last_name) VALUES #{escaped_values};"
    db.execute sql, slice
  end
end
