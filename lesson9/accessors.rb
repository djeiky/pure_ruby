module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      define_method(name) { instance_variable_get("@#{name}") }

      define_method("#{name}_history") { instance_variable_get("@#{name}_history") }

      define_method("#{name}=") do |value|
        name_history = instance_variable_get("@#{name}_history")
        instance_variable_set("@#{name}_history", []) if name_history.nil?
        instance_variable_set("@#{name}", value)
        instance_variable_get("@#{name}_history") << instance_variable_get("@#{name}")
      end
    end
  end

  def strong_attr_accessor(name, type)
    define_method(name) { instance_variable_get("@#{name}") }

    define_method("#{name}=") do |val|
      raise ArgumentError unless val.is_a? type

      instance_variable_set("@#{name}", val)
    end
  end
end
