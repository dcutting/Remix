# Remix

This workspace contains several sample iOS applications demonstrating the Remix architecture.

## Primary goals

* Compositional reuse of views, business logic, and feature flows in many contexts
* Predictable behaviour with many loosely coordinated developers
* Fast, stable automated testing for almost everything

## Guiding principles

* Loose coupling of components (for remixability)
* Cohesive separation of concerns (for predictability)
* Protocols and dependency injection (for testability)

## Points of interest

* The Coordinator pattern is central
* The familiar delegate pattern is the primary way components work together
* Features can be moved into their own pods for extra isolation and reuse
* Unit tests and acceptance tests don't depend on UIKit and run as very fast Mac logic tests without a simulator
* Dynamic frameworks can be statically relinked for fast launch time

## Apps

### Calculator

Simplest possible demonstration of Remix that includes all the major elements.

### Marketplace

A more complex app that lets users browse a collection of classified adverts, filter them by group, and create new adverts.

It remixes components in several ways:

* Two advert insertion flows share some of the same views, formatter and interactor but in different
* `GroupSelectionFeature` is used both for selecting a group for filtering the list of adverts, and for selecting a group when inserting a new advert
* `TextEntryStepView` is used in both insertion flows
* Generic `ItemDetailView` is used to display details about an advert
* `AlternatingInsertionFeature` alternates between the two insertion flows when inserting a new advert (for A/B testing, for example)
* `AutoGroupInsertionFeature` has its own interactor that automatically selects a group for a new advert, but also reuses the `InsertionInteractor` from the `ManualGroupInsertionFeature` to actually publish it
* Different flows for iPhone and iPad using all the same features
