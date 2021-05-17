//
//  MyPage.swift
//  Medic
//
//  Created by Hamlit Jason on 2021/05/04.
//

import UIKit
import Firebase
import FirebaseDatabase

class MyPage : UIViewController {
    
    @IBOutlet weak var rtableView: UITableView!
    @IBOutlet weak var loginLabel: UILabel!
    
    var SettingTitle = ["공지사항","이벤트","환경설정","서비스 약관"]
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Viewdid")
        rtableView.dataSource = self
        rtableView.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LabelTapped))
        
        loginLabel.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("ViewWill")
        self.ref = Database.database().reference() // 내 데이터베이스의 주소를 넣어준다.
        
        /*
        if self.appDelegate?.loginCheck == 1 { // 로그인된 상태이면
            //self.loginLabel.text = "로그인되었어요"
        }
        */
        
        if let user = Auth.auth().currentUser { // 이미 로그인 된 상태인지 확인하는 코드
            // 기기를 꺼도 로그인 상태가 유지된다.
            
            if appDelegate?.loginCheck == 1 {
                self.loginLabel.text = "회원: \(user.uid)"
                print("data access")
            }
            
        } else {
            self.loginLabel.text = "로그인해주세요."
        }
        
    }
    
   
    @IBAction func profilebtn(_ sender: Any) {
        
        if appDelegate?.loginCheck == 1 { // 로그인이 된 상태이면
            guard let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "MyprofilePageVC")  else {
                print("error")
                return
            }
            print("asd")
            vc2.modalPresentationStyle = .fullScreen
            self.present(vc2, animated: false, completion: nil)
        } else {
            // 로그인이 되어 있지 않다면
            let dialog = UIAlertController(title: nil, message: "로그인을 먼저 진행해주세요.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "로그인", style: .default) { (_) in
                
                guard let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "loginPageVC11")  else {
                    print("error")
                    return
                }
                print("asd")
                vc2.modalPresentationStyle = .fullScreen
                self.present(vc2, animated: false, completion: nil)
                
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            dialog.addAction(okAction)
            dialog.addAction(cancelAction)
            present(dialog, animated: true, completion: nil)
            
        }
        
        
    }
    
    

    @objc func LabelTapped(sender: UITapGestureRecognizer) { // 레이블 클릭시
        print("gg")
        guard let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "loginPageVC11") else {
            print("error")
            return
        }
        print("asd")
        
        vc2.modalPresentationStyle = .fullScreen
        self.present(vc2, animated: false, completion: nil)
        
    }
    
    @IBAction func ReserveInfo(_ sender: Any) {
        
        
        if appDelegate?.loginCheck == 1 { // 로그인이 된 상태이면
            guard let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "VerifyPage2VC") as? VerifyPage2 else {
                print("error")
                return
            }
            
            vc2.modalPresentationStyle = .fullScreen
            self.present(vc2, animated: false, completion: nil)
        } else {
            // 로그인이 되어 있지 않다면
            let dialog = UIAlertController(title: nil, message: "로그인을 먼저 진행해주세요.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "로그인", style: .default) { (_) in
                
                guard let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "loginPageVC11")  else {
                    print("error")
                    return
                }
                print("asd")
                vc2.modalPresentationStyle = .fullScreen
                self.present(vc2, animated: false, completion: nil)
                
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            dialog.addAction(okAction)
            dialog.addAction(cancelAction)
            present(dialog, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func unwind2(_ segue : UIStoryboardSegue) { // unwind 세그웨이 프로그래밍적으로 구현 - 왜냐하면 바로 이전화면이 아니라 더더 이전화면을 건너가야하는 경우도 생기니까.
        // 단지 프로필 화면으로 되돌아오기 위한 표식 역할만 할 뿐이므로 아무 내용도 작성하지 않는다
    }
    
}

extension MyPage : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rCell")
        cell?.textLabel?.text = SettingTitle[indexPath.row]

        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 사용자의 액션 처리를 위한 메소드
        NSLog("선택된 행은 \(indexPath.row)")
        
        if indexPath.row == 0 {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "NoticeListVC") else {
                return
            }
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        } else if indexPath.row == 1{
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "eventListVC") else {
                return
            }
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        } else if indexPath.row == 2 {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "envSetting") else {
                return
            }
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        } else if indexPath.row == 3{
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "clausePageVC") else {
                return
            }
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            
        }
    }
}
