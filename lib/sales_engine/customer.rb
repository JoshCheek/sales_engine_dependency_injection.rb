require 'sales_engine/record'
require 'sales_engine/invoice'

class SalesEngine
  class Customer < Record
    attribute :id,         Integer
    attribute :first_name, String
    attribute :last_name,  String
    attribute :created_at, DateTime
    attribute :updated_at, DateTime

    has_many  :invoices, table:       :invoices,
                         foreign_key: :customer_id,
                         klass:       :Invoice
  end
end
