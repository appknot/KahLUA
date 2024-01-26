//
//  KLAlertViewController.swift
//  BaseExtension
//
//  Created by Trudy on 2022/04/13.
//

import UIKit

public class KLAlertAppearance {
    public static let shared = KLAlertAppearance()
    
    public var titleFont: UIFont?
    public var titleColor: UIColor?
    public var messageFont: UIFont?
    public var messageColor: UIColor?
}

public class KLAlert: UIViewController {
    
    private let backgroundView = UIView()
    private let shadowView = UIView()
    private let alertView = UIView()
    private let buttonStackView = UIStackView()
    private let message: String
    
    private var alertTop: NSLayoutConstraint?
    private var alertLeading: NSLayoutConstraint?
    private var alertTrailing: NSLayoutConstraint?
    private var alertBottom: NSLayoutConstraint?
    private var titleTop: NSLayoutConstraint?
    private var messageTop: NSLayoutConstraint?
    private var messageBottom: NSLayoutConstraint?
    private var buttonStackViewHeight: NSLayoutConstraint?
    
    public var titleLabel: UILabel = {
        let label = UILabel()
        label.font = KLAlertAppearance.shared.titleFont
        label.textColor = KLAlertAppearance.shared.titleColor
        return label
    }()
    public var messageLabel: UILabel = {
        let label = UILabel()
        label.font = KLAlertAppearance.shared.messageFont
        label.textColor = KLAlertAppearance.shared.messageColor
        return label
    }()
    
    public var titleAttributedString: NSMutableAttributedString {
        get {
            if let attributedText = self.titleLabel.attributedText as? NSMutableAttributedString {
                return attributedText
            }
            return NSMutableAttributedString.init()
        }
        set {
            self.titleLabel.attributedText = newValue
        }
    }
    
    public var contentAttributedString: NSMutableAttributedString {
        get {
            if let attributedText = self.messageLabel.attributedText as? NSMutableAttributedString {
                return attributedText
            }
            return NSMutableAttributedString.init()
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
        
        setupBackgroundView(frame: self.view.bounds, color: UIColor.init(white: 0, alpha: 0.5), isEnableTabDismiss: true)
        view.addSubview(backgroundView)
        view.addSubview(shadowView)
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        alertTop = shadowView.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor, constant: 100)
        alertTop?.isActive = true
        alertLeading = shadowView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25)
        alertLeading?.isActive = true
        alertTrailing = shadowView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25)
        alertTrailing?.isActive = true
        alertBottom = shadowView.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor, constant: -100)
        alertBottom?.isActive = true
        
        NSLayoutConstraint.activate([
            shadowView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            shadowView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        shadowView.addSubview(alertView)
        alertView.addSubview(buttonStackView)
        alertView.backgroundColor = .white
        alertView.clipsToBounds = true
        
        alertView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            alertView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            alertView.topAnchor.constraint(greaterThanOrEqualTo: shadowView.topAnchor),
            alertView.bottomAnchor.constraint(lessThanOrEqualTo: shadowView.bottomAnchor)
        ])
        
        // button 영역
        alertView.addSubview(buttonStackView)
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 1
        buttonStackView.distribution = .fillEqually
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor)
        ])
        buttonStackViewHeight = buttonStackView.heightAnchor.constraint(equalToConstant: 50)
        buttonStackViewHeight?.isActive = true
        
        // 제목
        alertView.addSubview(titleLabel)
        titleLabel.text = self.title
        titleLabel.sizeToFit()
        titleLabel.textAlignment = .center
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTop = titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 20)
        titleTop?.isActive = true
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant:  -10)
        ])
        
        //내용
        alertView.addSubview(messageLabel)
        messageLabel.text = self.message
        messageLabel.sizeToFit()
        messageLabel.textAlignment = .center
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageTop = messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        messageTop?.isActive = true
        messageBottom = messageLabel.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -50)
        messageBottom?.isActive = true
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10),
        ])
    }
    
    // MARK: - Initializer
    public init(title: String?, message: String) {
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
     - leadingMargin : AlertView 완쪽 여백(고정)
     - trailingMargin : AlertView 오른쪽 여백(고정)
     - topMinMargin : AlertView의 최대사이즈의 상단 여백
     - bottomMinMargin : AlertView의 최대사이즈의 하단 여백
     - titleTopMarin : titleLabel의 상단 여백
     - messageTopMargin : messageLabel과 titleLabel 사이 여백
     - messageBottomMargin : messageLabel과 buttonStackView 사이 여백
     - cornerRadius : AlertView의 모서리 라운딩
     - isShawdowUse : 그림자 사용 유무
     */
    public func alertViewConfiguration(leadingMargin: CGFloat = 25,topMinMargin: CGFloat = 100, trailingMargin: CGFloat = -25, bottomMinMargin: CGFloat = -100, titleTopMargin: CGFloat = 20, messageTopMarin: CGFloat = 20, messageBottomMargin: CGFloat = -50, cornerRadius: CGFloat = 0, isShadowUse: Bool = true) {
        alertTop?.constant = topMinMargin
        alertLeading?.constant = leadingMargin
        alertTrailing?.constant = trailingMargin
        alertBottom?.constant = bottomMinMargin
        titleTop?.constant = titleTopMargin
        messageTop?.constant = messageTopMarin
        messageBottom?.constant = messageBottomMargin
        
        alertView.layer.cornerRadius = cornerRadius
        
        if isShadowUse {
            shadowView.layer.masksToBounds = false
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOpacity = 0.2
            shadowView.layer.shadowOffset = CGSize(width: 2, height: 2)
            shadowView.layer.shadowRadius = 10 / 2.0
            shadowView.layer.shadowPath = nil
        }
    }
    /**
     distribution이 fillEqually 인 경우 버튼의 width를 지정하지 않아도 1:1로 버튼 영역을 채움. fillEqually가 아닌 경우 addAction의 view를 width를 지정해 주어야 함
     */
    public func buttonStackViewConfiguration(backgroundColor: UIColor = .white, axis: NSLayoutConstraint.Axis = .horizontal, spacing: CGFloat = 1, distribution: UIStackView.Distribution = .fillEqually, height: CGFloat = 50) {
        buttonStackView.backgroundColor = backgroundColor
        buttonStackView.axis = axis
        buttonStackView.spacing = spacing
        buttonStackView.distribution = distribution
        buttonStackViewHeight?.constant = height
    }
    
    /**
     KLAlertAction 엇럿뷰에 들어가는 버튼 추가. 커스텀 버튼 사용하고 싶은 경우 KLAlertActionProtocol을 상속 받아 구현. 해당 함수 override 한뒤 super 호출, action.delegate = self로 연결. KLAlertAction에 관한 커스텀 필요시 addAction에서 구현
     */
    public func addAction(_ action: KLAlertAction) {
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
    
    public func show() {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(self, animated: false, completion: nil)
        }
    }
}

public class KLAlertAction: UIView {

    var handler: (() -> Void)?
    public let titleLabel = UILabel()
    
    // MARK: - Initializer
    public init(title: String, handler: (() -> Void)?) {
        self.handler = handler
        super.init(frame: .zero)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(actionHandler(_:)))
        self.addGestureRecognizer(tap)
        
        self.addSubview(titleLabel)
        titleLabel.frame = self.bounds
        titleLabel.text = title
        titleLabel.textAlignment = .center
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selector
    @objc func actionHandler(_ gesture: UITapGestureRecognizer) {
        guard let handler = handler else {
            return
        }
        handler()
    }
    
}
