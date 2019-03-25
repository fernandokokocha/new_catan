# frozen_string_literal: true

Dir[File.join(__dir__, 'catan', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'catan', 'entities', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'catan', 'interactors', '*.rb')].each { |file| require file }
