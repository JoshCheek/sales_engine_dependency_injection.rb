require 'sales_engine/invoice'

class SalesEngine
  class InvoiceRepository
    attr_accessor :db

    def initialize(db)
      self.db = db
    end

    def find_by_id(id)
      find_by id: id
    end

    def find_by(critieria)
      row = db.find_by :invoices, critieria
      Invoice.new row if row
    end
  end
end
