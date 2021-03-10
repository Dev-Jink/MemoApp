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
    
    // MARK: - IBOutlet
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    // MARK: - IBAction
    @IBAction func save(_ sender: Any) {
        // 내용을 입력하지 않았을 경우, 경고
        guard self.contents.text?.isEmpty == false else {
            self.alert("내용을 입력해주세요")
            return
        }
        
        // MemoData 객체를 생성 데이터를 담기
        let data = MemoData()
        
        data.title = self.subject               // 제목
        data.contents = self.contents.text      // 내용
        data.image = self.preview.image         // 이미지
        data.regdate = Date()                   // 작성 시간
        
        // 앱델리게이트는 싱글턴으로 되어있음 객체 읽기
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.memolist.append(data)
        
        dump(appDelegate.memolist)
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


