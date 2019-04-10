# frozen_string_literal: true

module ArrayUtils
  def self.find_duplication(array)
    array.detect do |item|
      array.count(item) > 1
    end
  end

  def self.find_by_attribute(array, attribute, value)
    array.detect { |item| item.send(attribute) == value }
  end
end
