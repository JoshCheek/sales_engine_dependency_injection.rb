SalesEngine = Class.new(Class.new) { const_set :Base, superclass }

require 'sales_engine/invoice_repository'
require 'sales_engine/customer_repository'

class SalesEngine::Base
  attr_accessor :db
  attr_accessor :customer_repository, :invoice_repository

  def initialize(db)
    self.db = db
  end

  def startup
    self.customer_repository = SalesEngine::CustomerRepository.new(db)
    self.invoice_repository  = SalesEngine::InvoiceRepository.new(db)
    self
  end
end
