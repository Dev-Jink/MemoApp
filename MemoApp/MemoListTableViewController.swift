//
//  MemoListTableViewController.swift
//  MemoApp
//
//  Created by MyeongJin on 2021/03/09.
//

import UIKit

class MemoListTableViewController: UITableViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: - Tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = self.appDelegate.memolist.count
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowData = self.appDelegate.memolist[indexPath.row]
        
        let cellId = rowData.image == nil ? "memoCell" : "memoCellWithImage"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MemoCell

        cell?.subject?.text = rowData.title
        cell?.contents?.text = rowData.contents
        cell?.img?.image = rowData.image
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        
        cell?.regdate?.text = formatter.string(from: rowData.regdate!)

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowData = self.appDelegate.memolist[indexPath.row]
        
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "MemoRead") as? MemoReadViewController else {
            return
        }
        
        viewController.param = rowData
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - Life Cycle
extension MemoListTableViewController {
    
    override func viewDidLoad() {
        // SWRevealViewController 라이브러리의 revealViewController 객체 load
        if let revealVC = self.revealViewController() {
            
            // bar 버튼 아이템 객체를 정의
            let btn = UIBarButtonItem()
            btn.image = UIImage(named: "sidemenu.png")  // 이미지는 sidemenu.png로
            btn.target = revealVC // 버튼 클릭 시 호출할 메소드가 정의된 객체를 지정
            btn.action = #selector(revealVC.revealToggle(_:)) // 버튼 클릭 시 revealToggle(_:) 호출
            
            // 정의된 바 버튼을 내비게이션 바의 왼쪽 아이템으로 등록
            self.navigationItem.leftBarButtonItem = btn
            
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
}
