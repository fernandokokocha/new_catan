# New Catan - The Settlers of Catan in Ruby TDD v2

Continuation of [Catan v1](https://github.com/fernandokokocha/catan)

## Short timeline

1. Started v1 in March 2015 in TDD
2. Abandoned in June 2015
3. Long, long break. No particular reason for that.
4. Picked up again in September 2018 as a cool way of imitating legacy code (I did learn a lot in the meantime)
5. In February 2019 went to the point where lacks in design held me back from moving forward; hence decision to start over

## Requirements

* Ruby 2.6.2

## Setup

* `bundle install`

## Mutant

Overcommit can't trigger mutant. Please don't commit any code that doesn't pass mutation tests.

To run:

`bundle exec mutant --use rspec 'SetupGame'`

The last argument is a pattern (could contain a '*' wildcard) for names (class and methods) to mutate.

## Other quality tools

Overcommit tool uses Rubocop, Reek, and RSpec on the adequate development phases. There's no need for additional configuration on your side.

If you want to run them separately:

### Test

Issue `bundle exec rspec` in the root directory.

### RuboCop

Issue `bundle exec rubocop` in the root directory.

### Reek

Issue `bundle exec reek` in the root directory.
