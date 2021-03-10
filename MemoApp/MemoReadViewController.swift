//
//  MemoReadViewController.swift
//  MemoApp
//
//  Created by MyeongJin on 2021/03/09.
//

import UIKit

class MemoReadViewController: UIViewController {

    var param: MemoData?
    
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var contents: UILabel!
}

extension MemoReadViewController {
    override func viewDidLoad() {
        self.subject.text = param?.title
        self.contents.text = param?.contents
        self.img.image = param?.image
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString = formatter.string(from: (param?.regdate)!)
        
        self.navigationItem.title = dateString
    }
}
