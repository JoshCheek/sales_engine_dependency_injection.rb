require 'sqlite3'
db_path = "sales_engine_from_csv.db"
db      = SQLite3::Database.new(db_path)
db.execute '
  CREATE TABLE customers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
  )
'

require 'csv'
csv_path = "/Users/josh/deleteme/sales_engines/sales_engine_spec_harness/data/customers.csv"
rows = CSV.foreach(csv_path, headers: true).map { |row|
  [row["id"].to_i, row["first_name"], row["last_name"]]
}

rows.each_slice 500 do |slice|
  sql_values = slice.map { |row| "(#{row.map(&:inspect).join(", ")})" }.join(", ")
  db.execute "
    INSERT INTO customers
           (id, first_name, last_name)
    VALUES #{sql_values}
  "
end

puts "NUMBER OF ROWS:"
p db.execute('select count(1) from customers').first.first
puts

puts "FIRST 10 ROWS:"
require 'pp'
pp db.execute('select * from customers limit 10')
