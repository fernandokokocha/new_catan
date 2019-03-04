# frozen_string_literal: true

Dir[File.join(__dir__, 'entities', '*.rb')].each { |file| require file }

Dir[File.join(__dir__, 'interactors', '*.rb')].each { |file| require file }

class Catan
end
