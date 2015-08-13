require 'sales_engine/record'
require 'sales_engine/customer'

class SalesEngine
  class Invoice < Record
    attribute :id,          Integer
    attribute :customer_id, Integer
    attribute :merchant_id, Integer
    attribute :status,      Symbol
    attribute :created_at,  DateTime
    attribute :updated_at,  DateTime

    belongs_to  :customer, table:       :customers,
                           foreign_key: :customer_id,
                           klass:       :Customer
  end
end
