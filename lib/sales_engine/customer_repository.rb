require 'sales_engine/customer'

class SalesEngine
  class CustomerRepository
    attr_accessor :db

    def initialize(db)
      self.db = db
    end

    def find_by_first_name(first_name)
      find_by first_name: first_name
    end

    def find_by_id(id)
      find_by id: id
    end

    def find_by_last_name(last_name)
      find_by last_name: last_name
    end

    def find_by_created_at(created_at)
      find_by created_at: created_at
    end

    def find_by_updated_at(updated_at)
      find_by updated_at: updated_at
    end

    def find_all_by_first_name(first_name)
      find_all_by first_name: first_name
    end

    def random
      row = db.random :customers
      Customer.new *row if row
    end

    def find_by(critieria)
      row = db.find_by(:customers, critieria)
      Customer.new *row if row
    end

    def find_all_by(critieria)
      db.find_all_by(:customers, critieria)
        .map { |row| Customer.new *row }
    end
  end
end
