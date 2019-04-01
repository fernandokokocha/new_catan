# frozen_string_literal: true

module ArrayUtils
  def self.find_duplication(array)
    array.detect do |item|
      array.count(item) > 1
    end
  end
end
