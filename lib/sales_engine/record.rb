require 'time'

class SalesEngine
  class Record
    def self.attribute(name, type)
      define_method(name) { attribute name, type }
    end

    def self.has_many(association)
      define_method association do
        db.find_all_by(association, fk_to_me => id)
          .map { |attrs| class_for(association).new(db, attrs) }
      end
    end

    def self.belongs_to(association)
      define_method association do
        attrs = db.find_by class_for(association).table_name, id: fk_to(association)
        class_for(association).new(db, attrs)
      end
    end

    protected

    def self.table_name
      @table_name ||= (name.split("::").last.downcase << "s").intern
    end

    def table_name
      self.class.table_name
    end

    private

    def initialize(db, attributes={})
      self.db         = db
      self.attributes = attributes
    end

    attr_accessor :db, :attributes

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

    def class_for(table_name)
      SalesEngine.const_get table_name.to_s.chomp("s").capitalize
    end

    def fk_to_me
      :"#{table_name.to_s.chomp "s"}_id"
    end

    def fk_to(association)
      attribute :"#{association}_id", Integer
    end
  end
end
