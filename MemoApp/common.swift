//
//  common.swift
//  MemoApp
//
//  Created by MyeongJin on 2021/03/09.
//

import Foundation
import UIKit

extension UIViewController {
    func alert(_ message: String?, complete: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            complete?()
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
