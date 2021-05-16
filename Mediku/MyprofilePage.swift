//
//  MyprofilePage.swift
//  Mediku
//
//  Created by Hamlit Jason on 2021/05/16.
//

import UIKit
import Firebase
import FirebaseDatabase

class MyprofilePage : UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var phone_field: UITextField!
    @IBOutlet weak var BirthLabel: UILabel!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference() // 내 데이터베이스의 주소를 넣어준다.
        
        if Auth.auth().currentUser != nil { // 이미 로그인 된 상태인지 확인하는 코드
            
            let user = Auth.auth().currentUser
            self.idLabel.text = "회원: \(user!.uid)"
            print("data access")
            
        } else {
            
        }
    }
    
    
    
    
    @IBAction func loginoutBtn(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
            print("logout access")
            
            self.loginoutAlert()
            self.idLabel.text = "아이디"
            self.phoneNumber.text = "연락처"
            self.BirthLabel.text = "생년월일"
            
        } catch let error as NSError {
            print("logout error code : %@", error)
        }
        
    }
    
    func loginoutAlert() {
        
        let dialog = UIAlertController(title: nil, message: "로그아웃되었습니다", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        dialog.addAction(okAction)
        present(dialog, animated: true, completion: nil)
        
    }
    
}
