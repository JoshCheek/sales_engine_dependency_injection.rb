require 'fileutils'

fixture_db = File.expand_path "fixtures/sales_engine.db", __dir__

FileUtils.rm_f    fixture_db
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

db.execute '
  INSERT INTO customers
         (first_name, last_name)
  VALUES ("Josh", "Cheek"),
         ("Matt", "Hecker");
'
