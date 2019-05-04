# frozen_string_literal: true

Dir[File.join(__dir__, 'catan', '*.rb')].each { |file| require file }

require File.join(__dir__, 'catan', 'state', 'state.rb')
require File.join(__dir__, 'catan', 'state', 'queryable_state.rb')

require File.join(__dir__, 'catan', 'entities', 'resources.rb')
Dir[File.join(__dir__, 'catan', 'entities', '*.rb')].each { |file| require file }

Dir[File.join(__dir__, 'catan', 'utils', '*.rb')].each { |file| require file }

Dir[File.join(__dir__, 'catan', 'helpers', '*.rb')].each { |file| require file }

require File.join(__dir__, 'catan', 'interactors', 'interactor.rb')
Dir[File.join(__dir__, 'catan', 'interactors', '*.rb')].each { |file| require file }

Dir[File.join(__dir__, 'catan', 'serializers', '*.rb')].each { |file| require file }
