class SalesEngine
  class MemoryDatabase
    def initialize(table_data)
      self.table_data = table_data
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
