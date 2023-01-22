module ActiveStorage
  module Helpers
    def interpolates(key, &block)
      ActiveStorage::Interpolations[key] = block
    end
  end
end
