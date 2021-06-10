//
//  reportList.swift
//  Medic
//
//  Created by Hamlit Jason on 2021/05/06.
//
// 가족창으로 용도 변경
import UIKit
import Firebase

class reportCell : UITableViewCell {
    @IBOutlet weak var RelationAttr: UILabel!
    @IBOutlet weak var userid: UILabel!
}

class reportList : UITableViewController {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    let user = Auth.auth().currentUser
    var ref: DatabaseReference! // 파이어베이스 리얼타임 데베 읽기 위해서 참조해야해
    var howmanycount : Int = 0
    override func viewDidLoad() {
        print("ViewDid")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("ViewWill")
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.appDelegate?.TestRelationAttr.count)
        return (self.appDelegate?.TestRelationAttr.count) as! Int
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell") as! reportCell
        cell.RelationAttr.text = self.appDelegate?.TestRelationAttr[indexPath.row]
        cell.userid.text = self.appDelegate?.TestFamilyList[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
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
        var RelationText = "" // 관계지정
        let dialog = UIAlertController(title: nil, message: "가족을 등록하시겠습니까?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
            ShareCode = dialog.textFields?[0].text ?? ""
            RelationText = dialog.textFields?[1].text ?? ""
            self.ref = Database.database().reference()
            
            self.ref.child("user/\(ShareCode)").getData { [self] (_: Error?, DataSnapshot) in
                // 데이터를 먼저 읽는다
                if DataSnapshot.exists() == true {
                    // uid 가 존재 즉, 초대한 회원코드를 정확히 입력 or 존재
                    self.ref.child("user/\(user!.uid)/family").updateChildValues([ShareCode: RelationText])
                    //self.ref.child("user/\(ShareCode)/family").updateChildValues([self.user!.uid: self.user!.uid])
                    appDelegate?.FamilyList.updateValue(RelationText, forKey: ShareCode)
                    appDelegate?.TestFamilyList.append(ShareCode)
                    appDelegate?.TestRelationAttr.append(RelationText)
                    print(appDelegate?.FamilyList.description)
                    DispatchQueue.main.async {
                        tableView.reloadData() // 메인스레드에서 작업해줘야함 - 테이블 뷰 새로고침하는 코드
                    }
                    
                } else {
                    
                }
                
                
            }
            
            print(ShareCode)
            //let subDialog = UIAlertController(title: nil, message: "ㅔ", preferredStyle: .alert)
            //let ll = UIAlertAction(title: "ok", style: .default, handler: nil)
            //subDialog.addAction(ll)
            //self.present(subDialog, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        dialog.addTextField { (tf) in
            tf.placeholder = "초대받은 코드를 입력해주세요."
            //ShareCode = dialog.textFields?[0].text ?? ""
        }
        
        dialog.addTextField { (tf) in
            tf.placeholder = "관계를 입력해주세요"
            //ShareCode = dialog.textFields?[0].text ?? ""
        }
        
        dialog.addAction(okAction)
        dialog.addAction(cancelAction)
        
        present(dialog, animated: true) {
            self.showToast(message: "a")
            print("ASD")
        }
    }
    
    
    
}
extension reportList {
    func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 14.0)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))

        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
    @IBAction func unwind3(_ segue : UIStoryboardSegue) { // unwind 세그웨이 프로그래밍적으로 구현 - 왜냐하면 바로 이전화면이 아니라 더더 이전화면을 건너가야하는 경우도 생기니까.
        // 단지 프로필 화면으로 되돌아오기 위한 표식 역할만 할 뿐이므로 아무 내용도 작성하지 않는다
    }
}
