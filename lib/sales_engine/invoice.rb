class SalesEngine
  class Invoice
    attr_accessor :attributes

    def initialize(attributes={})
      self.attributes = attributes
    end

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

    private

    def attribute(name, klass)
      value = attributes[name]

      if    value.nil?                                  then nil
      elsif value.kind_of?(klass)                       then value
      elsif value.kind_of?(String) && klass == Integer  then value.to_i
      elsif value.kind_of?(String) && klass == DateTime then DateTime.parse value
      elsif value.kind_of?(String) && klass == Symbol   then value.intern
      else  raise "WAT: #{value.inspect} #{klass.inspect}"
      end
    end
  end
end
