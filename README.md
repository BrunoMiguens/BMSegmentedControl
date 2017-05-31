# BMSegmentedControl

[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-blue.svg)](https://swift.org)  [![license](https://img.shields.io/badge/licence-MIT-blue.svg)](https://github.com/loiclec/Apodimark/blob/master/LICENCE.md) [![Build Status](https://travis-ci.org/BrunoMiguens/BMSegmentedControl.svg?branch=master)](https://travis-ci.org/BrunoMiguens/BMSegmentedControl)

This is a custom Segmented Control with icon and text on every segment.


## Usage

#### Initialization segmented control with icon
```swift
let segmentedControl = BMSegmentedControl.init(
            withIcon: CGRectMake(8, 50, screen.width - 16, 44),
            items: ["Happy", "Normal", "Sad"],
            icons: [UIImage(named: "happy_gray")!, UIImage(named: "flat_gray")!, UIImage(named: "sad_gray")!],
            selectedIcons: [UIImage(named: "happy_white")!, UIImage(named: "flat_white")!, UIImage(named: "sad_white")!],
            backgroundColor: UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1),
            thumbColor: UIColor.init(hex: "#54C3EF"),
            textColor: UIColor(hex: "#808080"),
            selectedTextColor: UIColor(hex: "#FFFFFF"),
            orientation: ComponentOrientation.LeftRight)
```

#### Initialization segmented control without icon
```swift
let segmentedControl = BMSegmentedControl.init(
            withoutIcon: CGRectMake(8, 50, screen.width - 16, 44),
            items: ["Happy", "Normal", "Sad"],
            backgroundColor: UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1),
            thumbColor: UIColor.init(hex: "#54C3EF"),
            textColor: UIColor(hex: "#808080"),
            selectedTextColor: UIColor(hex: "#FFFFFF"))
```


```swift
// To get the changed value event, set it manually on your view controller
segmentedControl.addTarget(self, action: #selector(self.action(_:)), forControlEvents: .ValueChanged)

// You need to add DPSegmnetedControl to container
self.view.addSubview(segmentedControl)

// You could set the selected index. Default is 0
segmentedControl.selectedIndex = 1
```

## Requirements

- iOS 8.0+
- Xcode 8

## Integration

#### CocoaPods (iOS 8+)

You can use [CocoaPods](http://cocoapods.org/) to install `BMSegmentedControl`by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
      pod 'BMSegmentedControl'
end
```

## Sample

![gif](http://i.giphy.com/iZvJT92KGkeiI.gif)

[This is the video sample](https://youtu.be/PaVUNysxyf4)

## License

BMSegmentedControl is released under the MIT license. See LICENSE for details.

