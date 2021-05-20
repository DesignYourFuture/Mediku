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
    
    
    @IBAction func CSPhoneNum(_ sender: Any) {
        let alert = UIAlertController(title: "연락처를 입력해주세요.", message: "textField", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) {
            (_) in
            self.phoneNumber.text = "연락처 : " + (alert.textFields?[0].text)!
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        alert.addTextField{ (myTextField) in
            myTextField.textColor = UIColor.blue
            myTextField.placeholder = "연락처를 입력해주세요."
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func CSPicker(_ sender: Any) {
        
        //let dialog = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = NSLocale(localeIdentifier: "ko_KO") as Locale // datePicker의 default 값이 영어이기 때문에 한글로 바꿔줘야한다. 그래서 이 방식으로 변경할 수 있다.
        
        let dateChooserAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        dateChooserAlert.view.addSubview(datePicker)
        dateChooserAlert.addAction(UIAlertAction(title: "선택완료", style: .cancel, handler: nil))
        //dialog.setValue(contentVC, forKey: "contentViewController") // private api
        
        let height : NSLayoutConstraint = NSLayoutConstraint(item: dateChooserAlert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 300)
        dateChooserAlert.view.addConstraint(height)
        
        present(dateChooserAlert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func changeDatePicker(_ sender: Any) {
        let datePickerView = sender // 센더라는 UIDatePicker 자료형의 인수가 전달된다.
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.BirthLabel.text = "생년월일 : " + formatter.string(from: (datePickerView as AnyObject).date)
    }
    
    
    
    @IBAction func backbtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
