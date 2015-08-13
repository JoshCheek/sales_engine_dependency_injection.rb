class SalesEngine
  class MemoryDatabase
    def initialize(table_data={})
      table_data = table_data.dup

      self.table_data = {
        customers: table_data.delete(:customers)||[],
      }
      raise "DON'T KNOW WHAT TO DO WITH THIS: #{table_data.keys.inspect}" if table_data.any?
    end

    def find_by(table, criteria)
      row = table_data[table].find do |row|
        criteria.all? do |attribute, value|
          row.fetch(attribute) == value
        end
      end
      row.values if row
    end

    def random(table)
      row = table_data[table].sample
      row.values if row
    end

    private

    attr_accessor :table_data
  end
end
