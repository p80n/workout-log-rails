module ActiveSupport
  module Inflector
    def titleize(word)
      word.gsub(/\b(?<!['’`])[a-z]/) { $&.capitalize }
    end
  end
end
