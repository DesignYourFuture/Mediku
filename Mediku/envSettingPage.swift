//
//  eventList.swift
//  Medic
//
//  Created by Hamlit Jason on 2021/05/07.
//

import UIKit

class envCellVO : UITableViewCell {
    
    @IBOutlet weak var swichBtn: UISwitch!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    
}


class envSettingPage : UITableViewController {
    
    var envlist = [envCellVO]() // 테이블 뷰를 구성할 리스트 데이터
    
    override func viewDidLoad() {
        //
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "envCell") as! envCellVO // 셀 타입 지정해주기
        if indexPath.row == 0 {
            cell.title.text = "서비스 알림"
            cell.detail.text = "진료정보 및 예상시간 이용 알림만 발송"
        } else if indexPath.row == 1 {
            cell.title.text = "이벤트, 광고 알림"
            cell.detail.text = "이벤트 및 광고알림 발송"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 79
    }
}
