class SalesEngine
  class Customer
    attr_accessor :id, :first_name, :last_name
    def initialize(id, first_name, last_name)
      self.id         = id
      self.first_name = first_name
      self.last_name  = last_name
    end
  end
end
