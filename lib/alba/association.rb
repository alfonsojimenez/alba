module Alba
  # Base class for `One` and `Many`
  # Child class should implement `to_hash` method
  class Association
    def initialize(name:, condition: nil, resource: nil, &block)
      @name = name
      @condition = condition
      @block = block
      @resource = resource || resource_class
      raise ArgumentError, 'resource or block is required' if @resource.nil? && @block.nil?
    end

    def to_hash
      :not_implemented
    end

    private

    def resource_class
      klass = Class.new
      klass.include(Alba::Resource)
      klass.class_eval(&@block)
      klass
    end
  end
end
