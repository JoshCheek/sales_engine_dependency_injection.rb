require 'sales_engine/record'

class SalesEngine
  class Customer < Record
    attribute :id,         Integer
    attribute :first_name, String
    attribute :last_name,  String
    attribute :created_at, DateTime
    attribute :updated_at, DateTime
  end
end
