require "text"

module DidYouMean
  class MethodMatcher
    attr_reader :method_collection, :target_method

    def initialize(method_collection, target_method)
      @method_collection = method_collection.uniq
      @target_method     = target_method.to_s
    end

    def similar_methods
      @similar_methods ||= method_collection.select do |method|
        ::Text::Levenshtein.distance(method.to_s, target_method) <= threshold
      end
    end

    private

    def threshold
      (target_method.size * 0.3).ceil
    end
  end
end