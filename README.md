# KahLUA

[![CI Status](https://img.shields.io/travis/woody-iOS/KahLUA.svg?style=flat)](https://travis-ci.org/woody-iOS/KahLUA)
[![Version](https://img.shields.io/cocoapods/v/KahLUA.svg?style=flat)](https://cocoapods.org/pods/KahLUA)
[![License](https://img.shields.io/cocoapods/l/KahLUA.svg?style=flat)](https://cocoapods.org/pods/KahLUA)
[![Platform](https://img.shields.io/cocoapods/p/KahLUA.svg?style=flat)](https://cocoapods.org/pods/KahLUA)

## Example
### KLLabel()
```ruby
let label = KLLabel()
label.text = "1234\n1234\n1234\n1234"
label.backgroundColor = .blue
label.frame = .init(x: 100, y: 300, width: 200, height: 300)
label.numberOfLines = 5
label.textColor = .black
label.kern = 5.0
label.textAlignment = .center
label.lineHeight = 50
label.font = UIFont.boldSystemFont(ofSize: 16)
// 특정 문자열에 옵션 값을 변경(단일)
label.change(string: "2", key: .font, value: UIFont.boldSystemFont(ofSize: 24))
label.change(string: "34", key: .font, value: UIFont.boldSystemFont(ofSize: 30))
// 모든 특정 문자열에 옵션 값을 변경
label.changes(string: "4", key: .foregroundColor, value: UIColor.red)
self.view.addSubview(label)
        
// KLLabel를 상속받아, 프로젝트별 스타일 가이드 생성
let label2 = PROJECTLabel(frame: .init(x: 14, y: 88, width: 300, height: 60))
label2.style = .navigationTitle
label2.text = "1234"
self.view.addSubview(label2)
```

## Installation

KahLUA is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'KahLUA'
```

## Author

woody-iOS, woody@appknot.com

## License

KahLUA is available under the MIT license. See the LICENSE file for more info.
