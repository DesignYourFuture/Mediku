//
//  RegisterPage.swift
//  Medic
//
//  Created by Hamlit Jason on 2021/05/09.
//
import UIKit
import Firebase
import FirebaseDatabase

struct DataInfo {
    
    // 유저정보
    var Id : String? // 아이디
    var Idformmat : String? // 메일 형식
    var name : String? // 이름
    
    // 예약정보
    var speciality : String? // 진료과
    var date : String? // 예약 시기
    var reserveNum : String? // 예약접수 번호
    var link : String? // 링크
    
}



class RegisterPage : UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var ref: DatabaseReference!

    
    //ref = Database.database().reference()
    
    @IBOutlet weak var pwchk: UILabel!
    
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var IdField: UITextField!
    @IBOutlet weak var PwField: UITextField!
    @IBOutlet weak var PwchkField: UITextField!
    
    override func viewDidLoad() {
        pwchk.numberOfLines = 0
        //IdField.textContentType = .creditCardNumber
        
    }
    
    
    
    @IBAction func registerBtn(_ sender: UIButton) {
        //print(PwField.text?.count)
        
        if CheckFieldFill() {
            AlertFill()
        } else if PwField.text!.count < 6 {
            AlertPwShort()
        } else if PwField.text! == PwchkField.text {
            Register()
        } else {
            AlertPwchk()
        }
    }
    
}

extension RegisterPage {
    
    func Register() {
        Auth.auth().createUser(withEmail: IdField.text!, password: PwField.text!) { // 신규회원 생성 코드
            // 중복 아이디의 경우 자동으로 fail시킨다
        (user, error) in
            
            self.ref = Database.database().reference() // 파이어베이스 데베 주소 가져와서
            print("\(error?.localizedDescription)")
            
            
            
            if user != nil {
                print ("register access")
                self.adduid()
                self.AlertSuccess()
                //self.dismiss(animated: true, completion: nil)
            } else {
                print("register fail")
                self.AlertFail(error! as NSError)
            }
        }
 
    }
    
    func adduid() {
        let user = Auth.auth().currentUser
        
        // 여기에다가 업데이트 작성
        var datalist = DataInfo()
        
        let email = String(self.IdField.text!)
        let name = String(self.NameField.text!)
        /*
        var arr =  email.components(separatedBy: "@")
        print(arr[0])
        var head = arr[0]
        arr = arr[1].components(separatedBy: ".")
        print(arr[0])
        head += arr[0]
        */
        self.ref.child("user").child(user!.uid).setValue([
            "Id" : email,
            //"Idformmat" : arr[1],
            "name" : name,
            "date" : "",
            "speciality" : "",
            "reserveNum" : "",
            "link" : ""
        ])
        
        
    }
    
    
    func AlertSuccess() {
        let dialog = UIAlertController(title: nil, message: "회원가입에 성공하였습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) {
            (_) in
            self.dismiss(animated: true, completion: nil)
        }
        dialog.addAction(okAction)
        present(dialog, animated: true, completion: nil)
    }
    
    func AlertFail(_ error : NSError) {
        let dialog = UIAlertController(title: nil, message: "\(error.localizedDescription)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        dialog.addAction(okAction)
        present(dialog, animated: true, completion: nil)
    }
    
    func AlertPwchk() {
        let dialog = UIAlertController(title: nil, message: "재입력된 비밀번호가 다릅니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        dialog.addAction(okAction)
        present(dialog, animated: true, completion: nil)
    }
    
    func AlertPwShort() {
        let dialog = UIAlertController(title: nil, message: "비밀번호의 길이는 6자리 이상이어야 합니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        dialog.addAction(okAction)
        present(dialog, animated: true, completion: nil)
    }
    
    func AlertFill() {
        let dialog = UIAlertController(title: nil, message: "모든 필드를 입력해주세요.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        dialog.addAction(okAction)
        present(dialog, animated: true, completion: nil)
    }
    
    func CheckFieldFill() -> Bool{
        var NameCount = self.NameField.text?.count
        var IdCount = self.IdField.text?.count
        var PwCount = self.PwField.text?.count
        var PwchkCount = self.PwchkField.text?.count
        
        if NameCount == 0 || IdCount == 0 || PwCount == 0 || PwchkCount == 0 {
            return true
        } else {
            return false
        }
    
    }
    
    
}
