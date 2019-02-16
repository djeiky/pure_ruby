module Validation
  def self.included(klass)
    klass.extend ClassMethods
    klass.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, options = nil)
      @validations ||= []
      @validations << { name: name, type: type, options: options }
    end
  end

  module InstanceMethods
    def validate?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def v_presence(value, _options = nil)
      raise 'No value given!' if value.nil?
    end

    def v_format(value, options)
      raise 'Invalid format!!' if value !~ options
    end

    def v_type(value, options)
      raise 'Invalid class' unless value.is_a? options
    end

    def validate!
      self.class.validations.each do |validation|
        value = instance_variable_get("@#{validation[:name]}")
        method = "v_#{validation[:type]}"
        send method, value, validation[:options]
      end
    end
  end
end
