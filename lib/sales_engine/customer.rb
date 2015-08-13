require 'time'

class SalesEngine
  class Customer
    attr_accessor :attributes

    def initialize(attributes={})
      self.attributes = attributes
    end

    def id
      attribute :id, Integer
    end

    def first_name
      attribute :first_name, String
    end

    def last_name
      attribute :last_name, String
    end

    def created_at
      attribute :created_at, DateTime
    end

    def updated_at
      attribute :updated_at, DateTime
    end

    private

    def attribute(name, klass)
      value = attributes[name]

      if    value.nil?                                  then nil
      elsif value.kind_of?(klass)                       then value
      elsif value.kind_of?(String) && klass == Integer  then value.to_i
      elsif value.kind_of?(String) && klass == DateTime then DateTime.parse value
      else  raise "WAT: #{value.inspect} #{klass.inspect}"
      end
    end
  end
end
