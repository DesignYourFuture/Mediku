//
//  RegisterPage2.swift
//  Mediku
//
//  Created by Hamlit Jason on 2021/05/15.
//

import UIKit

class VerifyPage2 : UIViewController {
    
    @IBOutlet weak var Check_Label2: UILabel! // 예약확인 여부
    @IBOutlet weak var speciality2: UILabel!
    @IBOutlet weak var Reserve_Date: UILabel!
    @IBOutlet weak var Reseve_number: UILabel!
    @IBOutlet weak var Reservelink: UILabel!
    
    var Veri1 = VerifyPage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func CSButton2(_ sender: Any) {
        CSAlert2()
    }
    
    
    
    func CSAlert2() {
        let dialog = UIAlertController(title: "고객센터로 연결하시겠습니까?", message: "상담가능시간 : 9:00~18:00(점심시간12:00~1:30)", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "0000-0000", style: .default){ (_) in
            let number:Int = 01011111111
            if let url = NSURL(string: "tel://0" + "\(number)"),
            UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        dialog.addAction(okAction)
        dialog.addAction(cancelAction)
        present(dialog, animated: true, completion: nil)
    }
}
