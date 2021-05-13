//
//  loginPage.swift
//  Medic
//
//  Created by Hamlit Jason on 2021/05/05.
//

import UIKit
import Firebase

class loginPage : UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var pwText: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        if self.appDelegate?.loginCheck == 0 { // 현재 로그인이 안되어 있는 상태면
            login()
        } else { // 로그인이 된 상태이면
            logout()
        }
    }
    
    
    
}

extension loginPage {
    func AlertSignFail(_ error : NSError) {
        let dialog = UIAlertController(title: nil, message: "\(error.localizedDescription)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        dialog.addAction(okAction)
        present(dialog, animated: true, completion: nil)
    }
    
    
    func login() {
        Auth.auth().signIn(withEmail: emailText.text!, password: pwText.text!) { // 로그인 확인 코드
        (user, error) in
            if user != nil {
                print ("login access")
                self.emailText.isHidden = true
                self.pwText.isHidden = true
                self.loginBtn.setTitle("로그아웃", for: .normal)
                self.appDelegate?.loginCheck = 1 // 로그인 상태로 변경
                
            } else {
                print("login fail")
                self.AlertSignFail(error as! NSError)
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            print("logout access")
            self.emailText.isHidden = false
            self.emailText.text = ""
            self.emailText.placeholder = "아이디를 입력해주세요"
            self.pwText.isHidden = false
            self.pwText.text = ""
            self.pwText.placeholder = "비밀번호를 입력해주세요."
            self.loginBtn.setTitle("로그인", for: .normal)
            self.appDelegate?.loginCheck = 0 // 로그아웃 상태로 변경
            
            
            
        } catch let error as NSError {
            print("logout error code : %@", error)
            self.AlertSignFail(error as! NSError)
        }
    }
}
