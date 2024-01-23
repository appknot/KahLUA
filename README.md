# KahLUA

[![CI Status](https://img.shields.io/travis/woody-iOS/KahLUA.svg?style=flat)](https://travis-ci.org/woody-iOS/KahLUA)
[![Version](https://img.shields.io/cocoapods/v/KahLUA.svg?style=flat)](https://cocoapods.org/pods/KahLUA)
[![License](https://img.shields.io/cocoapods/l/KahLUA.svg?style=flat)](https://cocoapods.org/pods/KahLUA)
[![Platform](https://img.shields.io/cocoapods/p/KahLUA.svg?style=flat)](https://cocoapods.org/pods/KahLUA)

## Example
### KLLabel
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
```
![스크린샷 2024-01-16 오후 5 46 06](https://github.com/appknot/KahLUA/assets/59425581/e741dfef-a9be-4a27-b930-c5d71da4dcd2)

### BaseAlert
```ruby
// alert 생성
let alert = BaseAlert(title: "알림", message: "알림 팝업입니다.")
        
// margin, backgroundColor, spacing등 configuration 설정
// 아래 setupBackgroundView은 모두 default값으로 변경이 없으면 호출하지 않아도됨.
alert.setupBackgroundView(
    frame: alert.view.bounds,
    color: UIColor.init(rgb: 0x000000, alpha: 0.5),
    isEnableTabDismiss: true
)
// 아래 alertViewConfiguration은 모두 default값으로 변경이 없으면 호출하지 않아도됨.
alert.alertViewConfiguration(
    leadingMargin: 25,
    topMinMargin: 100,
    trailingMargin: -25,
    bottomMinMargin: -100,
    cornerRadius: 10,
    isShadowUse: true
)
// 아래 buttonStackViewConfiguration은 모두 default값으로 변경이 없으면 호출하지 않아도됨.
alert.buttonStackViewConfiguration(
    backgroundColor: .white,
    axis: .horizontal,
    spacing:1,
    distribution: .fillEqually,
    height: 50
)
        
// title, messageLabel 변경
alert.titleLabel.font = .systemFont(ofSize: 20)
alert.messageLabel.textColor = .gray
alert.messageLabel.numberOfLines = 0
        
alert.titleAttributedString = NSMutableAttributedString(string: "알림", attributes: [.foregroundColor: UIColor.red])
alert.contentAttributedString = NSMutableAttributedString(string: "알림 팝업입니다.", attributes: [.foregroundColor: UIColor.blue])
        
// KLLabel 옵션 사용
alert.titleLabel.change(string: "림", key: .font, value: UIFont.systemFont(ofSize: 25))
alert.messageLabel.change(string: "알림", key: .foregroundColor, value: UIColor.black)
        
// BaseAlertAction 생성
let cancelAction = BaseAlertAction(title: "취소", handler: {
     alert.dismiss(animated: false)
})
cancelAction.backgroundColor = .black
cancelAction.titleLabel.font = .systemFont(ofSize: 15)
cancelAction.titleLabel.textColor = .white
        
let confirmAction = BaseAlertAction(title: "확인", handler: {
     alert.dismiss(animated: false)
})
confirmAction.backgroundColor = .black
confirmAction.titleLabel.font = .systemFont(ofSize: 15)
confirmAction.titleLabel.textColor = .white
        
alert.addAction(cancelAction)
alert.addAction(confirmAction)
        
alert.show()
```
![스크린샷 2024-01-23 오전 11 20 15](https://github.com/appknot/KahLUA/assets/59425581/8e114263-21a9-4ecf-92a1-794f9ec9dc48)


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
