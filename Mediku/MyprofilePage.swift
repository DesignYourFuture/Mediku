//
//  MyprofilePage.swift
//  Mediku
//
//  Created by Hamlit Jason on 2021/05/16.
//

import UIKit
import Firebase
import FirebaseDatabase

class MyprofilePage : UIViewController, UITextFieldDelegate, SendDataDelegate {
    
    
    func sendData(data: String) {
        phoneNumber.text = data
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            let viewController : ProfileTextController = segue.destination as! ProfileTextController // 우리가 데이터를 직접 보내는 과정이랑 유사하나, 해당 뷰 컨트롤러의 IBOulet에 직접 접근하지 않고, 저기서!!! 그냥 대리자 위임을 해준것 뿐이다.
            viewController.delegate = self
            // 즉, 내가(ReceiveController) 대리자가 되겠다는 것이다
        }
    }
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var phone_field: UITextField!
    @IBOutlet weak var BirthLabel: UILabel!

    // VC2에서 받아오기 위한 데이터 - 직접적으로 레이블에 대입할 수 없기 때문에
    var paramPhoneNumber : String?
    var paramBirthLabel : String?
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //phone_field.delegate = self
        
        self.ref = Database.database().reference() // 내 데이터베이스의 주소를 넣어준다.
        
        if Auth.auth().currentUser != nil { // 이미 로그인 된 상태인지 확인하는 코드
            
            let user = Auth.auth().currentUser
            self.idLabel.text = "회원: \(user!.uid)"
            print("data access")
            
        } else {
            
        }
    }
    
    

    
    @IBAction func CSPicker(_ sender: Any) {
        
        //let dialog = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        self.ref = Database.database().reference() // 내 데이터베이스의 주소를 넣어준다.
        
        let user = Auth.auth().currentUser
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = NSLocale(localeIdentifier: "ko_KO") as Locale // datePicker의 default 값이 영어이기 때문에 한글로 바꿔줘야한다. 그래서 이 방식으로 변경할 수 있다.
        
        let dateChooserAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        dateChooserAlert.view.addSubview(datePicker)
        
        let okAction = UIAlertAction(title: "선택완료", style: .default) { (_) in
            let datePickerView = sender // 센더라는 UIDatePicker 자료형의 인수가 전달된다.
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let selectValue = formatter.string(from: datePicker.date)
            print(formatter.string(from: datePicker.date))
            self.BirthLabel.text = "생년월일 : " + selectValue
            
            
            // 파이어베이스에 업데이트 된다.
            let post = [
                "Birth" : selectValue // 생년월일

            ] as [String : Any]
            
            let childUpdates = [ // 없으면 새로 작성되고, 있으면 있는거 유지한 상태로 업데이트 된다.
                "user/\(user!.uid)/Birth" : post["Birth"]
            ]
            
            self.ref.updateChildValues(childUpdates)
            
        }
        dateChooserAlert.addAction(okAction)
        //dateChooserAlert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
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
            
            appDelegate?.loginCheck = 0
            
        } catch let error as NSError {
            print("logout error code : %@", error)
        }
        
    }
    
    func loginoutAlert() {
        
        let dialog = UIAlertController(title: nil, message: "로그아웃되었습니다", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) {
            (_) in
            self.dismiss(animated: true, completion: nil)
        }
        dialog.addAction(okAction)
        
        present(dialog, animated: true, completion: nil)
        
    }
    /*
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let text = textField.text else {return false}
            
            // 최대 글자수 이상을 입력한 이후에는 중간에 다른 글자를 추가할 수 없게끔 작동
            if text.count >= 11 && range.length == 0 && range.location < 11 {
                return false
            }
            
            return true
    }
    */
    
    @IBAction func NumBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileTextControllerVC") as! ProfileTextController
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self // 델리게이트 패턴 사용할 때 꼭 위임자 줘야해..
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func myExit(sender: UIStoryboardSegue) {
        // 언와인드 세그웨이
    }
}
