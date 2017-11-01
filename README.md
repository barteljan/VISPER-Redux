# VISPER-Redux

[![CI Status](http://img.shields.io/travis/barteljan/VISPER-Redux.svg?style=flat)](https://travis-ci.org/barteljan/VISPER-Redux)
[![Version](https://img.shields.io/cocoapods/v/VISPER-Redux.svg?style=flat)](http://cocoapods.org/pods/VISPER-Redux)
[![License](https://img.shields.io/cocoapods/l/VISPER-Redux.svg?style=flat)](http://cocoapods.org/pods/VISPER-Redux)
[![Platform](https://img.shields.io/cocoapods/p/VISPER-Redux.svg?style=flat)](http://cocoapods.org/pods/VISPER-Redux)

VISPER-Redux is an implementation of the redux-architecture in swift. It helps you to seperate three important concerns of your iOS-App.

* *State*: in a VISPER-Redux app the entire app state is explicitly stored in a data structure. This helps avoid complicated state management code, enables better debugging and has many, many more benefits.
* *Views*: in a VISPER-Redux app your views update when your state changes. Your views become simple visualizations of the current app state.
* *State Changes*: in a VISPER-Redux app you can only perform state changes through actions. Actions are small pieces of data that describe a state change. By drastically limiting the way state can be mutated, your app becomes easier to understand and it gets easier to work with many collaborators.

It is heavyly inspired by [ReReactiveSwift](https://github.com/ReSwift/ReactiveReSwift) (we even copied most of it's documentation since the architecture is nearly identical) and adds just some extensions to tackle composite app states and some integration features to use it in the [VISPER](https://github.com/barteljan/VISPER)-Application Framework.


If you want to learn more about redux, have a look at the following tutorials and documentations:

* [A cartoon guide to Flux](https://code-cartoons.com/a-cartoon-guide-to-flux-6157355ab207)
* [A cartoon Intro to Redux](https://code-cartoons.com/a-cartoon-intro-to-redux-3afb775501a6)
* [redux.js Documentation](http://redux.js.org/docs/introduction/)

## Getting startet

...

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

VISPER-Redux is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'VISPER-Redux'
```

## Author

barteljan, jan.bartel@atino.net

## License

VISPER-Redux is available under the MIT license. See the LICENSE file for more info.
