module ActiveStorage
  module Interpolations
    extend self
    MINIMUM_TOKEN_LENGTH = 28

    def self.[]=(name, block)
      define_method(name, &block)
    end

    def self.all
      self.instance_methods(false).sort!
    end

    def self.any?
      self.interpolators_cache.any?
    end

    def self.interpolate(pattern, *args)
      interpolators_cache.each do |method, token|
        pattern.gsub!(token) { send(method, *args) } if pattern.include?(token)
      end
      result
    end

    def self.interpolators_cache
      @interpolators_cache ||= all.reverse!.map! { |method| [method, ":#{method}"] }
    end
  end
end
