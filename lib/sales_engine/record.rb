require 'time'

class SalesEngine
  class Record

    private

    def initialize(attributes={})
      self.attributes = attributes
    end

    attr_accessor :attributes

    def attribute(name, klass)
      value = attributes[name]

      if    value.nil?                                  then nil
      elsif value.kind_of?(klass)                       then value
      elsif value.kind_of?(String) && klass == Integer  then value.to_i
      elsif value.kind_of?(String) && klass == DateTime then DateTime.parse value
      elsif value.kind_of?(String) && klass == Symbol   then value.intern
      else  raise "WAT: #{value.inspect} #{klass.inspect}"
      end
    end
  end
end
