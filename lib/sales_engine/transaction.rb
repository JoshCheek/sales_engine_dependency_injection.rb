require 'sales_engine/record'
require 'sales_engine/invoice'

class SalesEngine
  class Transaction < Record
    attribute :id,                          Integer
    attribute :invoice_id,                  Integer
    attribute :credit_card_number,          String
    attribute :credit_card_expiration_date, DateTime
    attribute :result,                      Symbol
    attribute :created_at,                  DateTime
    attribute :updated_at,                  DateTime

    has_many  :invoices, table:       :invoices,
                         foreign_key: :customer_id,
                         klass:       :Invoice
  end
end
