require 'time'

class SalesEngine
  class Record
    def self.attribute(name, type)
      define_method(name) { attribute name, type }
    end

    private

    def initialize(attributes={})
      self.attributes = attributes
    end

    attr_accessor :attributes

    def attribute(name, klass)
      value = attributes[name]

      if    value.nil?                                      then nil
      elsif value.kind_of?(klass)                           then value
      elsif klass == Integer  && value.respond_to?(:to_i)   then value.to_i
      elsif klass == DateTime && value.respond_to?(:to_str) then DateTime.parse value.to_str
      elsif klass == Symbol   && value.respond_to?(:to_sym) then value.to_sym
      else  raise "WAT: #{value.inspect} #{klass.inspect}"
      end
    end
  end
end
