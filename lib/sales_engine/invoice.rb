require 'sales_engine/record'

class SalesEngine
  class Invoice < Record
    def id
      attribute :id, Integer
    end

    def customer_id
      attribute :customer_id, Integer
    end

    def merchant_id
      attribute :merchant_id, Integer
    end

    def status
      attribute :status, Symbol
    end

    def created_at
      attribute :created_at, DateTime
    end

    def updated_at
      attribute :updated_at, DateTime
    end
  end
end
