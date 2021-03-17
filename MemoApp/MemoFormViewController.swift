//
//  MemoFormViewController.swift
//  MemoApp
//
//  Created by MyeongJin on 2021/03/09.
//

import UIKit

class MemoFormViewController: UIViewController, UINavigationControllerDelegate {

    // MARK: - properties
    var subject: String!    // navigation title value
    lazy var dao = MemoDAO()
    
    // MARK: - IBOutlet
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    // MARK: - IBAction
    @IBAction func save(_ sender: Any) {
        // 경고창에 사용될 콘텐츠 뷰 컨트롤러 구성
        let alertV = UIViewController()
        let iconImage = UIImage(named: "warning-icon-60")
        alertV.view = UIImageView(image: iconImage)
        alertV.preferredContentSize = iconImage?.size ?? CGSize.zero
        
        
        // 내용을 입력하지 않았을 경우, 경고
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            alert.setValue(alertV, forKey: "contentViewController")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // MemoData 객체를 생성 데이터를 담기
        let data = MemoData()
        
        data.title = self.subject               // 제목
        data.contents = self.contents.text      // 내용
        data.image = self.preview.image         // 이미지
        data.regdate = Date()                   // 작성 시간
        
        // 앱델리게이트는 싱글턴으로 되어있음 객체 읽기
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //appDelegate.memolist.append(data)
        
        // 코어 데이터에 메모 데이터를 추가
        self.dao.insert(data)
    
        // 작성 뷰 종료, 이전화면 복귀
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pick(_ sender: Any) {
        // 이미지 피커 인스턴스 생성
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        //  이미지 피커 표시
        self.present(picker, animated: false, completion: nil)
    }

}
// MARK: - Life Cycle
extension MemoFormViewController {
    override func viewDidLoad() {
        self.contents.delegate = self
        
        // 배경 이미지 설정
        let bgImage =  UIImage(named: "memo-background.png")!
        self.view.backgroundColor = UIColor(patternImage: bgImage)
        
        // 텍스트 뷰의 기본 속성
        self.contents.layer.borderWidth = 0
        self.contents.layer.borderColor = UIColor.clear.cgColor
        self.contents.backgroundColor = UIColor.clear
        
        // 줄 간격
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9
        self.contents.attributedText = NSAttributedString(string: " ", attributes: [.paragraphStyle: style])
        self.contents.text = ""
    }
}

// MARK: - UIImagePickerControllerDelegate
extension MemoFormViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 선택된 이미지를 미리보기에 출력
        self.preview.image = info[.editedImage] as? UIImage
        
        // 이미지 피커 컨트롤러 닫기
        picker.dismiss(animated: false, completion: nil)
    }
}

// MARK: - UITextViewDelegate
extension MemoFormViewController: UITextViewDelegate {
    // 사용자가 텍스트 뷰에 입력시 자동 호출
    func textViewDidChange(_ textView: UITextView) {
        // 내용의 최대 15자리를 subject에 저장
        let contents = textView.text as NSString
        let length = ( (contents.length > 15) ? 15 : contents.length )
        self.subject = contents.substring(with: NSRange(location: 0, length: length) )
        
        // 네비게이션 타이틀에 표시
        self.navigationItem.title = self.subject
    }
}

// MARK: - NUINavigationControllerDelegate
extension MemoFormViewController {
    // 탭 시 내비게이션 바 숨김
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let bar = self.navigationController?.navigationBar
        
        let ts = TimeInterval(0.3)
        UIView.animate(withDuration: ts) {
            bar?.alpha = ( bar?.alpha == 0 ? 1 : 0 )
        }
    }
}
