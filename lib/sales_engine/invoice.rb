class SalesEngine
  class Invoice
    attr_accessor :attributes

    def initialize(attributes)
      self.attributes = attributes
    end

    def id
      attributes[:id]
    end

    def status
      attributes[:status]
    end
  end
end
