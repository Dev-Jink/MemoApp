//
//  Utils.swift
//  MemoApp
//
//  Created by MyeongJin on 2021/03/15.
//

import Foundation
import UIKit
extension UIViewController {
    var tutorialSB: UIStoryboard {
        return UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    }
    
    func instanceTutorialVC(name: String) -> UIViewController? {
        return self.tutorialSB.instantiateViewController(identifier: name)
    }
}
