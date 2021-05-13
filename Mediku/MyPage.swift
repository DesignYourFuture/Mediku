//
//  MyPage.swift
//  Medic
//
//  Created by Hamlit Jason on 2021/05/04.
//

import UIKit
import Firebase

class MyPage : UIViewController {
    
    @IBOutlet weak var rtableView: UITableView!
    @IBOutlet weak var loginLabel: UILabel!
    
    var SettingTitle = ["공지사항","이벤트","환경설정","서비스 약관"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rtableView.dataSource = self
        rtableView.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LabelTapped))
        
        loginLabel.addGestureRecognizer(tapGestureRecognizer)

        
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
        }else if indexPath.row == 2 {
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
