//
//  NoticeList.swift
//  Medic
//
//  Created by Hamlit Jason on 2021/05/05.
//

import UIKit

class NoticeList : UITableViewController {
    
    
    var NoticeTitle = ["서비스 이용약관 개정 안내","개인정보 처리방침 개정 안내"]

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        //MypageVC
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeCell")
        cell?.textLabel?.text = String(NoticeTitle[indexPath.row])

        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.paramIndex = indexPath.row
        self.performSegue(withIdentifier: "NoticeSegue", sender: self)
    }
    
}
