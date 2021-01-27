## What is this?

This is the iOS library of Andes.
Andes is the design language used at Mercado Libre.

## How to use?

AndesUI is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:
```ruby
pod "AndesUI"
```

then run pod install.

## Useful links

* [Wiki](https://github.com/mercadolibre/fury_andesui-ios/wiki)
* [Contributing](https://github.com/mercadolibre/fury_andesui-ios/blob/develop/CONTRIBUTING.md)

## Example

This repo contains a demo application with examples about how to use the different components available in the library.

## Architecture
![AndesArq-iOS (1)](https://user-images.githubusercontent.com/57450033/73199660-ffcc8900-4113-11ea-830a-6555a9f292fe.jpg)


This is a generic representation of how a component should be built, however there may be some variations, feel free to reach out to the team and ask for explanations.

## Considerations

* All components were thought to follow similar implementation patterns, make sure you familiarize with a few of them before implementing a new one, you should follow the same methodologies as the previous components.
* Each component should have an entry on the wiki, if you are adding or updating one, please add the changes to the related entry.
* All components must work nicely with ObjC, please test that they do so.
* Bugs or feature requests should be submitted at our GitHub Issues section.

Before implementing a component or raising an issue please reach out to the UX team, all design changes must be approved by them.


## Author

Mercado Libre.

## License

AndesUI is available under the MIT license. See the LICENSE file for more info.
