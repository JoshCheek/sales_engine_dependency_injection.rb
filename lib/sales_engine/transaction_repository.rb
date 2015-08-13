require 'sales_engine/transaction'

class SalesEngine
  class TransactionRepository
    attr_accessor :db

    def initialize(db)
      self.db = db
    end

    def find_by_id(id)
      find_by id: id
    end

    def find_by(critieria)
      row = db.find_by(:transactions, critieria)
      Transaction.new db, row if row
    end
  end
end
