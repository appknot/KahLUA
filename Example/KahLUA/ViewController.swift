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
        
        KahLUA().alog("123")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

