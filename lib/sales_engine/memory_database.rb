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
      table_data[table].find do |row|
        criteria.all? do |attribute, value|
          row.fetch(attribute) == value
        end
      end
    end

    def find_all_by(table, criteria)
      table_data[table].select do |row|
        criteria.all? do |attribute, value|
          row.fetch(attribute) == value
        end
      end
    end

    def random(table)
      table_data[table].sample
    end

    private

    attr_accessor :table_data
  end
end
