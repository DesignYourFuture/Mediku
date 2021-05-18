//
//  VerifyPage.swift
//  Medic
//
//  Created by Hamlit Jason on 2021/05/03.
//
import UIKit
import Firebase

class VerifyPage : UIViewController{
    
    @IBOutlet weak var Check_Label: UILabel! // 예약확인 여부
    @IBOutlet weak var Speciality_Label: UILabel!
    @IBOutlet weak var Date_Label: UILabel!
    @IBOutlet weak var ReserveNum_Label: UILabel!
    @IBOutlet weak var Link_Label: UILabel!
    
    var ref: DatabaseReference!
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    //var dict = [String:Any]() // 딕셔너리 선언
    
    override func viewDidLoad() {
        self.ref = Database.database().reference() // 내 데이터베이스의 주소를 넣어준다.
        
        let user = Auth.auth().currentUser
        /*
        self.ref.child("user/\(user!.uid)").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                //print("Got data \(snapshot.value!)")
                //print(type(of: snapshot.value!))
                self.appDelegate!.dict = snapshot.value! as! [String : Any]
                print(self.appDelegate!.dict)
            }
            else {
                print("No data available")
            }
        }
        */
        if self.appDelegate!.dict["link"] as? String == nil {
            self.Check_Label.text = "예약이 접수되었어요"
        } else {
            self.Check_Label.text = "예약 링크를 확인해주세요!"
            self.Date_Label.text = "진료 시간 : -- "
        }
        
        self.Speciality_Label.text = self.appDelegate!.dict["speciality"] as? String
        self.Date_Label.text = self.appDelegate!.dict["date"] as? String
        self.ReserveNum_Label.text = self.appDelegate!.dict["reserveNum"] as? String
        self.Link_Label.text = self.appDelegate!.dict["link"] as? String
            
    }
    
    
    @IBAction func CSButton(_ sender: UIButton) {
        CSAlert()
    }
    
    func CSAlert() {
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


