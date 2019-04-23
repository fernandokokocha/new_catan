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

1. `bundle install`
2. `overcommit --install` - to install git hooks from .overcommit.yml

## How to test

1. Aim for black-box approach. Arrange, act and assert only via main entity - `Game`
2. Prefer real interactors in tests. In special cases (complicated setup, unnecessary overhead), use synthetic (test) interactors.
3. The aim is 100% coverage in mutation tests. However, this applies to non-trivial units like interactors.

## Mutant

Overcommit can't trigger mutant. To run:

`bundle exec mutant --use rspec 'SetupGame'`

The last argument is a pattern (could contain a '*' wildcard) for names (class and methods) to mutate.

## Other quality tools

Overcommit tool uses Rubocop, Reek, and RSpec on the adequate development phases. Other than installation git hooks (see: Setup), there's no need for additional configuration on your side.

If you want to run them separately:

### Test

Issue `bundle exec rspec` in the root directory.

### RuboCop

Issue `bundle exec rubocop` in the root directory.

### Reek

Issue `bundle exec reek` in the root directory.
