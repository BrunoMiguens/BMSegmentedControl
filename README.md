# BMSegmentedControl

[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-blue.svg)](https://swift.org)  [![license](https://img.shields.io/badge/licence-MIT-blue.svg)](https://github.com/loiclec/Apodimark/blob/master/LICENCE.md) [![Build Status](https://travis-ci.org/BrunoMiguens/BMSegmentedControl.svg?branch=master)](https://travis-ci.org/BrunoMiguens/BMSegmentedControl)

This is a custom Segmented Control with icon and text on every segment.

![gif](https://image.ibb.co/jdSqxa/view_2.png)

## Usage

#### Initialization segmented control with icon

```swift
let segmentedControl = BMSegmentedControl(withIcon: view.bounds,
      items: ["Happy", "Normal", "Sad"],
      icons: [UIImage(named: "happy_gray")!, UIImage(named: "flat_gray")!, UIImage(named: "sad_gray")!],
      selectedIcons: [UIImage(named: "happy_white")!, UIImage(named: "flat_white")!, UIImage(named: "sad_white")!],
      backgroundColor: .white,
      thumbColor: .lightGray,
      textColor: .black,
      selectedTextColor: .cyan,
      orientation: .leftRight
)
```

#### Initialization segmented control without icon

```swift
let segmentedControl = BMSegmentedControl(withoutIcon: view.bounds,
      items: titles,
      backgroundColor: .white,
      thumbColor: .lightGray,
      textColor: .black,
      selectedTextColor: .cyan
      )
```


```swift
// To get the changed value event, set it manually on your view controller
segmentedControl.addTarget(self, action: #selector(segmentedHasChanged), for: .valueChanged)

// You need to add BMSegmnetedControl to container
view.addSubview(segmentedControl)

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
      pod 'BMSegmentedControl', '~> 0.4.2'
end
```

## License

BMSegmentedControl is released under the MIT license. See LICENSE for details.

