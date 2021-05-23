//
//  ProfileTextController.swift
//  Mediku
//
//  Created by Hamlit Jason on 2021/05/21.
//

import UIKit
import Firebase

protocol SendDataDelegate {
    func sendData(data: String)
}

class ProfileTextController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var submit: UIButton!
    
    var ref: DatabaseReference!
    var delegate : SendDataDelegate?
    
    var maxLength = 11 // 최대 글자길이
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true // 네비게이션 바 숨기기
        
        view.backgroundColor = UIColor(cgColor: CGColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.75)) // 뷰를 투명하게
        
        textField.textColor = .white
        // 텍스트필드 커스텀하기 위해서 - 밑줄 만드는 코드
        textField.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: textField.frame.size.height-1, width: textField.frame.width, height: 1)
        border.backgroundColor = UIColor.white.cgColor
        //border.borderWidth = 5.0
        textField.layer.addSublayer((border))
        self.submit!.isHidden = true
        self.submit.tintColor = .gray
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: textField) // 옵저버 부착 - rxswift로도 비슷하게 구현 가능하다고 알고 있음.
        // 글자수 옵저버로 체크하기 위해
    }
    
    @objc func textDidChange(_ notification : Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                if text.count > maxLength {
                    // 11글자 넘어가면 키보드 자동으로 내려감
                    textField.resignFirstResponder()
                }
                
                if text.count >= maxLength {
                    /*
                     >= 처리한 이유는 한글 특성한 "안녕하세ㅇ" 입력시 키보드가 사라지기 때문
                     */
                    let index = text.index(text.startIndex, offsetBy: maxLength)
                    let newString = text[text.startIndex..<index]
                    textField.text = String(newString)
                } else if text.count < maxLength-1 { // 011의 경우 10글자 010의 경우 11글자
                    warningLabel.text = "연락처를 완성시켜주세요"
                    warningLabel.textColor = .red
                    self.submit!.isHidden = true
                } else {
                    warningLabel.text = "입력한 연락처가 맞습니까?"
                    warningLabel.textColor = .green
                    self.submit!.isHidden = false
                    self.submit.tintColor = .white
                }
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 글자가 쓰여질 때마다 호출되는 메소드
        
        guard let text = textField.text else {
            return false
        }
        
        if text.count >= maxLength && range.length == 0 && range.location <= maxLength {
            return false
        }
        return true
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil) // 언와인드 안걸어도 얘는 된다.
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        if let data = textField.text {
            delegate?.sendData(data: data)
            /*dismiss(animated: true, completion: nil) 이 코드가 작동되지 않는다
             근데 backbtn에서는 된다.
             */
            
            self.ref = Database.database().reference() // 내 데이터베이스의 주소를 넣어준다.
            
            let user = Auth.auth().currentUser
            
            let post = [
                "PhoneNumber" : textField.text // 생년월일

            ] as [String : Any]
            
            let childUpdates = [ // 없으면 새로 작성되고, 있으면 있는거 유지한 상태로 업데이트 된다.
                "user/\(user!.uid)/PhoneNumber" : post["PhoneNumber"]
            ]
            
            self.ref.updateChildValues(childUpdates)
            
        }
    }
}
