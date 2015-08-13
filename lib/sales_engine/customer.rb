class SalesEngine
  class Customer
    attr_accessor :attributes

    def initialize(attributes)
      self.attributes = attributes
    end

    def id
      attributes[:id]
    end

    def first_name
      attributes[:first_name]
    end

    def last_name
      attributes[:last_name]
    end

    def created_at
      attributes[:created_at]
    end

    def updated_at
      attributes[:updated_at]
    end
  end
end
