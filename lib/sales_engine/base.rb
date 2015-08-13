SalesEngine = Class.new Class.new
require 'sales_engine/customer_repository'

class SalesEngine
  Base = superclass
  class Base
    attr_accessor :db, :customer_repository

    def initialize(db)
      self.db = db
    end

    def startup
      self.customer_repository = CustomerRepository.new(db)
      self
    end
  end
end
