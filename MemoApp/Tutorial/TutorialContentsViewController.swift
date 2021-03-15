//
//  TutorialContentsViewController.swift
//  MemoApp
//
//  Created by MyeongJin on 2021/03/15.
//

import Foundation
import UIKit
class TutorialContentsViewController: UIViewController {
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        // 이미지를 꽉 채울 수 있게
        self.bgImageView.contentMode = .scaleAspectFill
        
        //전달받은 타이틀 정보를 레이블 객체에 대입하고 크기를 조절
        self.titleLabel.text = self.titleText
        self.titleLabel.sizeToFit()
        
        // 전달 받은 이미지 정보를 이비지 뷰에 대입
        self.bgImageView.image = UIImage(named: self.imageFile)
    }
}
