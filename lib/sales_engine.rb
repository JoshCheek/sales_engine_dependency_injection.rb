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
    insert_customers db.sqlite3
    insert_invoices  db.sqlite3

    super
  end

  private

  def csv_path_to(table)
    File.join csv_path, "#{table}.csv"
  end

  def insert_customers(sqlite3)
    table_name = :customers
    sqlite3.execute "
      CREATE TABLE  #{table_name} (
        id INTEGER  PRIMARY KEY AUTOINCREMENT,
        first_name  TEXT,
        last_name   TEXT,
        created_at  DATETIME,
        updated_at  DATETIME
      )
    "
    colnames, *rows = CSV.foreach(csv_path_to table_name).to_a
    rows.each_slice 500 do |slice|
      escaped_row    = '(' << (slice.first||[]).map { '?' }.join(',') << ')'
      escaped_values = slice.map { escaped_row }.join(',')
      sql            = "INSERT INTO #{table_name} (#{colnames.join(', ')}) VALUES #{escaped_values};"
      sqlite3.execute sql, slice
    end
  end

  def insert_invoices(sqlite3)
    table_name = :invoices
    sqlite3.execute "
      CREATE TABLE #{table_name} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customer_id INTEGER,
        merchant_id INTEGER,
        status      TEXT,
        created_at  DATE,
        updated_at  DATE
      )
    "
    colnames, *rows = CSV.foreach(csv_path_to table_name).to_a
    rows.each_slice 500 do |slice|
      escaped_row    = '(' << (slice.first||[]).map { '?' }.join(',') << ')'
      escaped_values = slice.map { escaped_row }.join(',')
      sql            = "INSERT INTO #{table_name} (#{colnames.join(', ')}) VALUES #{escaped_values};"
      sqlite3.execute sql, slice
    end
  end
end
