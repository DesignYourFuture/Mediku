//
//  loginPage.swift
//  Medic
//
//  Created by Hamlit Jason on 2021/05/05.
//

import UIKit
import Firebase

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class loginPage : UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var pwText: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    
    //let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("DDDD")
        if appDelegate?.loginCheck == 1 {
            self.registerBtn.isHidden = true
            self.loginLabel.isHidden = true
            self.pwText.isHidden = true
            self.emailText.isHidden = true
            self.loginBtn.setTitle("로그아웃", for: .normal)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        if appDelegate?.loginCheck == 0 { // 현재 로그인이 안된상태
            login()
            
            //registerBtn.isHidden = true
        } else { // 로그인이 된 상태
            logout()
            //registerBtn.isHidden = false
        }
    }
    
    
    
}

extension loginPage {
    func AlertLoginSuccess() {
        let dialog = UIAlertController(title: "Success", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        dialog.addAction(okAction)
        present(dialog, animated: true, completion: nil)
    }
    
    
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
                appDelegate?.loginCheck = 1 // 로그인 상태로 변경
                self.registerBtn.isHidden = true
                self.loginLabel.isHidden = true
                self.AlertLoginSuccess()
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
            appDelegate?.loginCheck = 0 // 로그아웃 상태로 변경
            self.registerBtn.isHidden = false
            self.loginLabel.isHidden = false
            
        } catch let error as NSError {
            print("logout error code : %@", error)
            self.AlertSignFail(error as! NSError)
        }
    }
}
