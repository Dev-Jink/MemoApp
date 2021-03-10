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

extension MemoListTableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
}
