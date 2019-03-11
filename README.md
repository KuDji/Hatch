[![CocoaPods Compatible](https://img.shields.io/badge/pod-v.1.0.4-orange.svg)](https://img.shields.io/badge/pod-v.1.0.6-orange.svg)
[![Platform](https://img.shields.io/badge/platform-ios-lightgrey.svg?style=flat)](https://img.shields.io/badge/platform-ios-lightgrey.svg)
[![Twitter](https://img.shields.io/badge/twitter-KuDji-blue.svg?style=flat)](https://twitter.com/KuDjij)

## Requirements

- iOS 10.0+ 
- Xcode 10.1+
- Swift 4.2+

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate Hatch into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'Hatch'
```

## How To

Form a alert with the title, image and button:

```swift

var hatch: Hatch!

func presentHatch() {
    let batchViewWidth: CGFloat = 300
    let titleText = "Title Text Example!"
    let textColor = UIColor.black
    let imageExmple = UIImage(named: "Ouroboros")
    let imageClose = UIImage(named: "Close")
    let imageSize = CGSize(width: 50, height: 50)
    let buttonText = "Done"

    let config = HatchConfigurator()
    let batchView = HatchBench(sizeWidth: batchViewWidth)
    let closeView = HatchCloseMark(image: imageClose, size: CGSize(width: 28, height: 28))
    hatch = Hatch(bench: batchView, closeMark: closeView, configuraction: config, onView: self.view)
    let hatchLabel = HatchLabel(text: titleText, color: textColor)
    let hatchImage = HatchUIImageView(image: imageExmple, size: imageSize)
    let hatchButoon = HatchButton(text: buttonText, action: #selector(test))

    hatch.addImage(hatchImage)
    hatch.addLabel(hatchLabel)
    hatch.addButton(hatchButoon)

    hatch.present()
}

@objc func test() {
    print("Success")
}
```

## License
`Hatch` is released under the MIT license. Check `LICENSE.md` for details.

## Contact
If you need to contact my [tweeter](https://twitter.com/KuDjij)
