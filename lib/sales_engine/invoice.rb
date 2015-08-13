require 'sales_engine/record'

class SalesEngine
  class Invoice < Record
    attribute :id,          Integer
    attribute :customer_id, Integer
    attribute :merchant_id, Integer
    attribute :status,      Symbol
    attribute :created_at,  DateTime
    attribute :updated_at,  DateTime
  end
end
