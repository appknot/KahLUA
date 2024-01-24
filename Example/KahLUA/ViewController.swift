//
//  ViewController.swift
//  KahLUA
//
//  Created by woody-iOS on 01/15/2024.
//  Copyright (c) 2024 woody-iOS. All rights reserved.
//

import UIKit
import KahLUA

enum PROJECTFontStyle {
    case navigationTitle

    case header1
    case header2

    case description1
    case description2
    case description3

    case footer
}

class PROJECTLabel: KLLabel {
    var style: PROJECTFontStyle? {
        didSet {
            switch style {
            case .navigationTitle:
                self.font = UIFont.boldSystemFont(ofSize: 44); self.lineHeight = 30; self.kern = 0.8;
            case .header1:
                self.font = UIFont.systemFont(ofSize: 15); self.lineHeight = 30; self.kern = 0.8;
            case .header2:
                self.font = UIFont.systemFont(ofSize: 15); self.lineHeight = 26; self.kern = 1.5;
            case .description1:
                self.font = UIFont.systemFont(ofSize: 16); self.lineHeight = 20; self.kern = 0.55;
            case .description2:
                self.font = UIFont.systemFont(ofSize: 12); self.lineHeight = 16; self.kern = -0.45;
            case .description3:
                self.font = UIFont.systemFont(ofSize: 10); self.lineHeight = 14; self.kern = -0.45;
            case .footer:
                self.font = UIFont.systemFont(ofSize: 15); self.lineHeight = 14; self.kern = -0.3;
            case .none:
                break
            }
        }
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .green
        
        // attributedText를 사용하지 않아도 kern, lineHeight 속성을 사용할 수 있음
        let label = KLLabel()
        label.text = "1234\n1a2b3c4d5e6f7g8h"
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
        label.changes(regularExpression: "[A-Za-z]", key: .foregroundColor, value: UIColor.purple)
        self.view.addSubview(label)
        
        // KLLabel를 상속받아, 프로젝트별 스타일 가이드 생성
        let label2 = PROJECTLabel(frame: .init(x: 14, y: 88, width: 300, height: 60))
        label2.style = .navigationTitle
        label2.text = "1234"
        self.view.addSubview(label2)
        
        KahLUA().alog("123")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // alert 생성
        let alert = BaseAlert(title: "알림", message: "알림 팝업입니다.")
        
        
        // margin, backgroundColor, spacing등 configuration 설정
        // 아래 setupBackgroundView은 모두 default값으로 변경이 없으면 호출하지 않아도됨.
//        alert.setupBackgroundView(
//            frame: alert.view.bounds,
//            color: UIColor.init(rgb: 0x000000, alpha: 0.5),
//            isEnableTabDismiss: true
//        )
        // 아래 alertViewConfiguration은 모두 default값으로 변경이 없으면 호출하지 않아도됨.
//        alert.alertViewConfiguration(
//            leadingMargin: 25,
//            topMinMargin: 100,
//            trailingMargin: -25,
//            bottomMinMargin: -100,
//            cornerRadius: 10,
//            isShadowUse: true
//        )
        // 아래 buttonStackViewConfiguration은 모두 default값으로 변경이 없으면 호출하지 않아도됨.
//        alert.buttonStackViewConfiguration(
//            backgroundColor: .white,
//            axis: .horizontal,
//            spacing:1,
//            distribution: .fillEqually,
//            height: 50
//        )
        
        // title, messageLabel 변경
//        alert.titleLabel.font = .systemFont(ofSize: 20)
//        alert.messageLabel.textColor = .gray
//        alert.messageLabel.numberOfLines = 0
        
//        alert.titleAttributedString = NSMutableAttributedString(string: "알림", attributes: [.foregroundColor: UIColor.red])
//        alert.contentAttributedString = NSMutableAttributedString(string: "알림 팝업입니다.", attributes: [.foregroundColor: UIColor.blue])
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

