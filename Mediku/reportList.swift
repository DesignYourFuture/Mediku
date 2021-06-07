//
//  reportList.swift
//  Medic
//
//  Created by Hamlit Jason on 2021/05/06.
//
// 가족창으로 용도 변경
import UIKit
import Firebase

class reportList : UITableViewController {
    
    var ref: DatabaseReference! // 파이어베이스 리얼타임 데베 읽기 위해서 참조해야해
    
    override func viewDidLoad() {
        //
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell")

        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
    @IBAction func shareInfo(_ sender: Any) {
        var objectToShare = [String]()
        /*
         < 가족초대 코드 문자 메시지 내용 >
         ... [Mediku] 000 님의 가족알림 요청입니다.
         등록을 원하시는 경우 아래의 코드를 가족으로 등록해주세요!
         코드 : \(uid)
         */
        if let myuid = Auth.auth().currentUser?.uid {
            objectToShare.append("""
                [Mediku] 000 님의 가족알림 요청입니다.
                등록을 원하시는 경우 아래의 코드를 복사해 가족으로 등록해주세요!
                코드 :
                """) // 여러줄로 나눠쓰는 경우는 스위프트에서는 """ 세개 이용하며 줄바꿈도 필수적으로 해야한다..
            objectToShare.append(String(myuid))
        }
       
        let activityVC = UIActivityViewController(activityItems : objectToShare, applicationActivities: nil)
        
        // 공유하기 기능 중 제외할 기능이 있을 때 사용
        //activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    @IBAction func addInfo(_ sender: Any) {
        var ShareCode = "" // 초대 코드 입력
        
        let dialog = UIAlertController(title: nil, message: "가족을 등록하시겠습니까?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
            ShareCode = dialog.textFields?[0].text ?? ""
            self.ref = Database.database().reference()
            
            self.ref.child("user/\(ShareCode)").getData { (_: Error?, DataSnapshot) in
                // 데이터를 먼저 읽는다
                if DataSnapshot.exists() == true {
                    // uid 가 존재 즉, 초대한 회원코드를 정확히 입력 or 존재
                    let subDialog = UIAlertController(title: nil, message: "가족등록이 완료되었습니다.", preferredStyle: .alert)
                    let subOkAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                    subDialog.addAction(subOkAction)
                    self.present(subDialog, animated: true, completion: nil)
                } else {
                    // 초대 코드가 잘못되었거나 존재하지 않는 경우
                    let subDialog = UIAlertController(title: nil, message: "잘못된 코드입니다.", preferredStyle: .alert)
                    let subOkAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                    subDialog.addAction(subOkAction)
                    self.present(subDialog, animated: true, completion: nil)
                }
                
                
            }
            
            print(ShareCode)
            let subDialog = UIAlertController(title: nil, message: "ㅔ", preferredStyle: .alert)
            let ll = UIAlertAction(title: "ok", style: .default, handler: nil)
            subDialog.addAction(ll)
            self.present(subDialog, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        dialog.addTextField { (tf) in
            tf.placeholder = "초대받은 코드를 입력해주세요."
            //ShareCode = dialog.textFields?[0].text ?? ""
        }
        dialog.addAction(okAction)
        dialog.addAction(cancelAction)
        
        present(dialog, animated: true, completion: nil)
    }
}
