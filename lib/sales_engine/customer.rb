require 'sales_engine/record'

class SalesEngine
  class Customer < Record
    def id
      attribute :id, Integer
    end

    def first_name
      attribute :first_name, String
    end

    def last_name
      attribute :last_name, String
    end

    def created_at
      attribute :created_at, DateTime
    end

    def updated_at
      attribute :updated_at, DateTime
    end
  end
end
