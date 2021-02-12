## [Unreleased]
### Added
- TradeWithBank interactor

### Changed
- ...

## [0.8.0]
### Added
- BuySettlement interactor
- GrantSettlement helper interactor
- BuyRoad interactor

## [0.7.1]
### Changed
- Fixed GameSerializer and GameDeserializer after adding

## [0.7.0]
### Added
- BuyCard interactor (only victory cards so far)

### Changed
- Extracted score calculations to ScoreCalculator helper

## [0.6.0]
### Added
- TurnTypeCalculator helper
- GainResources interactor

### Changed
- Game logic: gain resources only on second settle with road action
- CurrentPlayerCalculator type: module -> class

## [0.5.0]
### Added
- Player score

### Changed
- QueryableState extracted from State

## [0.4.0]
### Changed
- GameSerializator and GameDeserializator work on string-based hash rather than symbol-based
- Serialization is JSON compatible
- Deserialization from JSON

## [0.3.1]
### Added
- SettleWithRoad interactor: validation of spots bordering

## [0.3.0]
### Added
- GameDeserializer utility

## [0.2.0]
### Added
- Test interactors (used to synthetically manipulate state in tests)
- CurrentPlayerCalculator helper
- GameSerializer utility
- index attribute to Player entity

## [0.1.1]
### Changed
- Bugfix: Corrected indexes for regular tiles
- Bugfix: SettleWithRoad resources gaining

## [0.1.0]
### Added
- Chit (frequency) to Tile entity
- Desert Tile

## [0.0.5]
### Changed
- Reorder file loading in gem entry point

## [0.0.4]
### Changed
- Reference from Tile entity to Resources entity

## [0.0.3]
### Added
- Color attribute to players
- EndTurn interactor
- Resources entity
- Tile entity
- TileInitializer helper
- ArrayUtils module

### Changed
- Ruby version `2.4.1` -> `2.6.2`
- MapGeometry type (entity -> helper)
- base interactor behavior and data flow (therefore each interactor individually too)

## [0.0.2]
### Added
- Game structure: Game and State classes communicating with outside world via InteractionSuccess and InteractionFailure result objects
- SetupGame interactor
- SettleWithRoad interactor
- MapGeometry entity
- Player entity
- Road entity
- Settlement entity

## [0.0.1]
### Added
- Project setup
- Quality tools: rspec
- Quality tools: reek
- Quality tools: rubocop
- Quality tools: mutant
- Quality tools: overcommit (will run all above except mutant)
