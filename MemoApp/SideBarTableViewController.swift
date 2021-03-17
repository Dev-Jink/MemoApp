//
//  SideBarTableViewController.swift
//  MemoApp
//
//  Created by MyeongJin on 2021/03/13.
//

import UIKit

class SideBarTableViewController: UITableViewController {
    // MARK: - Properties
    let userInfo = UserInfoManager() // 개인 정보 관리 매니저
    let nameLabel = UILabel() // 이름 레이블
    let emailLabel = UILabel() // 이미지 레이블
    let profileImage = UIImageView() // 프로필 이미지
    // 목록 데이터 배열
    let titles = [
        "새글 작성하기",
//        "친구 새글",
//        "달력으로 보기",
//        "공지사항",
//        "통계",
        "계정관리"
    ]
   
    // 아이콘 데이터 배열
    let icons = [
        UIImage(named: "icon01.png"),
//        UIImage(named: "icon02.png"),
//        UIImage(named: "icon03.png"),
//        UIImage(named: "icon04.png"),
//        UIImage(named: "icon05.png"),
        UIImage(named: "icon06.png")
    ]
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.titles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "menucell" // 테이블 셀 식별자
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        // 타이틀 이미지를 대입
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        
        // 폰트 설정
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == self.titles.firstIndex(of: "새글 작성하기") { // 선택된 행이 새글 작성 메뉴일 떄
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "MemoForm")
            let target = self.revealViewController()?.frontViewController as! UINavigationController
            target.pushViewController(uv!, animated: true)
            self.revealViewController()?.revealToggle(self)
        } else if indexPath.row == self.titles.firstIndex(of: "계정관리") {
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "_Profile")
            uv?.modalPresentationStyle = .fullScreen
            self.present(uv!, animated: true) {
                self.revealViewController()?.revealToggle(self)
            }
        }
    }
}
// MARK: - Life Cycle
extension SideBarTableViewController {
    override func viewDidLoad() {
        // 테이블 뷰의 헤더 역할을 할 뷰를 정의
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        
        headerView.backgroundColor = .brown
        
        // 테이블 뷰의 헤더 뷰를 지정
        self.tableView.tableHeaderView = headerView
        
        // 이름 레이블 속성 정의, 헤더 뷰에 추가
        self.nameLabel.frame = CGRect(x: 70, y: 15, width: 100, height: 30)
        //self.nameLabel.text = "김 명진"
        self.nameLabel.textColor = .white
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        self.emailLabel.backgroundColor = .clear
        
        headerView.addSubview(self.nameLabel) // 헤더뷰에 추가
        
        // 이메일 레이블의 숙성을 정의, 헤더 뷰에 추가
        self.emailLabel.frame = CGRect(x: 70, y: 30, width: 150, height: 30) // 위치와 크기를 정의
        //self.emailLabel.text = "shinyjade94@gmail.com" // 기본 텍스트
//        self.emailLabel.sizeToFit()
//        self.emailLabel.frame.origin = CGPoint(x: 70, y: 35)
        self.emailLabel.textColor = .white // 텍스트 색상
        self.emailLabel.font = UIFont.systemFont(ofSize: 11) // 퐅트 사이즈
        self.emailLabel.backgroundColor = .clear // 배경 색상
        
        headerView.addSubview(self.emailLabel) // 헤더뷰에 추가
        
        // 기본 이미지 구현
        //let defaultProfile = UIImage(named: "account.jpg")
        //self.profileImage.image = defaultProfile // 이미지 등록
        self.profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        
        self.profileImage.layer.cornerRadius = (self.profileImage.frame.width / 2) // 반원 형태로 라운딩
        
        self.profileImage.layer.borderWidth = 0 // 테두리 두께 0
        self.profileImage.layer.masksToBounds = true // 마스크 효과
        
        headerView.addSubview((self.profileImage)) // 헤더 뷰에 추가
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.nameLabel.text = self.userInfo.name ?? "Guest"
        self.emailLabel.text = self.userInfo.account ?? ""
        self.profileImage.image = self.userInfo.profile
    }
}
