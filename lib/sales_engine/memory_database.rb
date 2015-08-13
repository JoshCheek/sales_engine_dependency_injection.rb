class SalesEngine
  class MemoryDatabase
    def initialize(table_data={})
      table_data = table_data.dup

      self.table_data = {
        customers: table_data.delete(:customers) || [],
        invoices:  table_data.delete(:invoices)  || [],
      }
      raise "DON'T KNOW WHAT TO DO WITH THIS: #{table_data.keys.inspect}" if table_data.any?
    end

    def find_by(tablename, criteria)
      table(tablename).find do |row|
        criteria.all? do |attribute, value|
          row.fetch(attribute) == value
        end
      end
    end

    def find_all_by(tablename, criteria)
      table(tablename).select do |row|
        criteria.all? do |attribute, value|
          row.fetch(attribute) == value
        end
      end
    end

    def random(tablename)
      table(tablename).sample
    end

    private

    attr_accessor :table_data

    def table(tablename)
      table_data.fetch tablename
    end
  end
end
