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

    belongs_to :invoice, table:       :invoices,
                         foreign_key: :invoice_id,
                         klass:       :Invoice
  end
end
