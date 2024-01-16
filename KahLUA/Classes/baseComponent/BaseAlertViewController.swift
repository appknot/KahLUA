//
//  BaseAlertViewController.swift
//  BaseExtension
//
//  Created by Trudy on 2022/04/13.
//

import UIKit

public class BaseAlertViewController: UIViewController {
    
    private let backgroundView = UIView()
    let alertView = UIView()
    
    private let buttonContainer = UIView()
    private let buttonStackView = UIStackView()
    
    private let message: String
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    
    var titleAttributedString: NSMutableAttributedString {
        get {
            self.titleAttributedString
        }
        set {
            self.titleLabel.attributedText = newValue
        }
    }
    
    var contentAttributedString: NSMutableAttributedString {
        get {
            self.contentAttributedString
        }
        set {
            self.messageLabel.attributedText = newValue
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        self.modalPresentationStyle = .overFullScreen
        
        // dimmed background
        setupBackgroundView(frame: self.view.bounds, color: .black, isEnableTabDismiss: true)
        view.addSubview(backgroundView)
        
        // content 담기는 alert 영역
        view.addSubview(alertView)
        alertView.addSubview(buttonContainer)
        alertView.addSubview(buttonStackView)
        alertView.backgroundColor = .white
        alertView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 50, height: 180)
        alertView.center = self.view.center
        alertView.backgroundColor = .white
        
        // button 영역
        alertView.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor).isActive = true
        
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 10
        buttonStackView.distribution = .fillEqually
        
        // 제목
        alertView.addSubview(titleLabel)
        titleLabel.text = self.title
        titleLabel.sizeToFit()
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: 0, y: 20, width: alertView.frame.size.width, height: titleLabel.frame.size.height)
        
        alertView.addSubview(messageLabel)
        messageLabel.text = self.message
        messageLabel.sizeToFit()
        messageLabel.textAlignment = .center
        messageLabel.frame = CGRect(x: 0, y: titleLabel.frame.height + titleLabel.frame.origin.y + 30, width: alertView.frame.size.width, height: messageLabel.frame.size.height)
        
    }
    
    // MARK: - Initializer
    init(title: String?, message: String) {
        self.message = message
        super.init(nibName: nil, bundle: nil)
        self.title = title
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Appearance
    /**
     distribution이 fillEqually 인 경우 버튼의 width를 지정하지 않아도 1:1로 버튼 영역을 채움. fillEqually가 아닌 경우 addAction의 view를 width를 지정해 주어야 함
     */
    public func buttonStackViewConfiguration(axis: NSLayoutConstraint.Axis, spacing: CGFloat = 10, distribution: UIStackView.Distribution) {
        buttonStackView.axis = axis
        buttonStackView.spacing = spacing
        buttonStackView.distribution = distribution
    }
    
    /**
     버튼 들어가는 영역의 마진을 설정하고 싶은 경우 호출하여 마진 지정
     */
    public func buttonStackViewMargin(leading: CGFloat, trailing: CGFloat, bottom: CGFloat) {
        for constraint in buttonStackView.constraints {
            buttonStackView.removeConstraint(constraint)
        }
        
        buttonStackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: leading).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: trailing).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: bottom).isActive = true
    }
    
    /**
     BaseAlertAction 엇럿뷰에 들어가는 버튼 추가. 커스텀 버튼 사용하고 싶은 경우 BaseAlertActionProtocol을 상속 받아 구현. 해당 함수 override 한뒤 super 호출, action.delegate = self로 연결. BaseAlertAction에 관한 커스텀 필요시 addAction에서 구현
     */
    func addAction(_ action: BaseAlertAction) {
        buttonStackView.addArrangedSubview(action)
    }
    
    /**
     기본 값 0x000000, alpha 0.5로 백그라운드 생성하며, 백그라운드 변경 원할 시 아래 함수 호출. override 불가
     - Parameters:
        - frame: background 사이즈
        - color: background color, alpha 값 함께 줄 수 있음
        - isEnableTabDismiss: background 터치 시 dismiss 되는 옵션
     */
    public final func setupBackgroundView(frame: CGRect, color: UIColor, isEnableTabDismiss: Bool) {
        backgroundView.backgroundColor = color
        backgroundView.frame = frame
        
        if isEnableTabDismiss {
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView(_:)))
            backgroundView.addGestureRecognizer(tap)
        }
    }
    
    /**
     애니메이션이 들어간 dismiss 하고 싶은 경우 overried 해서 사용. 내부 클래스의 dismiss는 해당 함수를 사용해서 dismiss 시켜 주고 있음
     */
    @objc func dismissView(_ recognizer: UITapGestureRecognizer) {
        self.dismiss(animated: false)
    }
    
    /**
     가장 최상위 뷰에 얼럿 뷰를 띄움
     ~~~
     // example
     CustomAlertViewController.topViewController()?.present(alertView, animated: false)
     ~~~
     */
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    
}

/**
 UIAlertAction.Style과 같음
 */
enum BaseAlertActionStyle {
    case cancel
    case destructive
    case normal
}

/**
 커스텀 버튼을 사용하는 경우 BaseAlertActionProtocol을 채택한 후 UIView에 넣어줌
 */
protocol BaseAlertActionAppearance {
    var cancelView: UIView { get }
    var destructiveView: UIView { get }
    var normalView: UIView { get }
}

public class BaseAlertAction: UIView {
    
    var delegate: BaseAlertActionAppearance? {
        get {
            return self.delegate
        }
        set {
            for view in self.subviews {
                view.removeFromSuperview()
            }
            
            var view: UIView?
            switch type {
            case .cancel:
                view = newValue?.cancelView
            case .destructive:
                view = newValue?.destructiveView
            case .normal:
                view = newValue?.normalView
            }
            
            guard let view = view else {
                return
            }
            
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            view.topAnchor.constraint(equalTo: topAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
    }
    var handler: (() -> Void)?
    
    let titleLabel = UILabel()
    let type: BaseAlertActionStyle
    
    // MARK: - Initializer
    init(title: String, style: BaseAlertActionStyle, height: CGFloat = 50, handler: (() -> Void)?) {
        self.handler = handler
        self.type = style
        super.init(frame: .zero)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(actionHandler(_:)))
        self.addGestureRecognizer(tap)
        
        self.addSubview(titleLabel)
        titleLabel.frame = self.bounds
        titleLabel.text = title
        titleLabel.textAlignment = .center
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Appearance
    public func titleRect(leading: CGFloat, top: CGFloat, trailing: CGFloat, bottom: CGFloat) {
        for constraint in titleLabel.constraints {
            self.titleLabel.removeConstraint(constraint)
        }
        
        self.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: top).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailing).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottom).isActive = true
        titleLabel.textAlignment = .center
    }
    
    
    // MARK: - Selector
    @objc func actionHandler(_ gesture: UITapGestureRecognizer) {
        guard let handler = handler else {
            return
        }
        handler()
    }
    
}
