//
//  ReservePage.swift
//  Medic
//
//  Created by Hamlit Jason on 2021/05/03.
//

import UIKit
import Firebase

var RecieveDoctorList = DoctorData()

class ReservePage : UIViewController {
    
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var pickerDate: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var ref: DatabaseReference!
    
    var paramName : String = "심제균"
    
    let formatter = DateFormatter()
    let Hourformatter = DateFormatter()
    let Minformatter = DateFormatter()
    
    var CheckHourStart : String = "1"
    var CheckMinStart : String = "1"
    var CheckHourEnd : String = "1"
    var CheckMinEnd : String = "1"
    
    override func viewDidLoad() {
        //performSegue(withIdentifier: "ListSelectSegue", sender: self)
        print(RecieveDoctorList)
        let docimgName = RecieveDoctorList.longDoctorImage
        
        self.img.image = (UIImage(named: String(docimgName!)) ?? UIImage(named: "no_docimg(A).PNG"))!
        
    }
    
    @IBAction func startPicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        formatter.dateFormat = "HH:mm"
        Hourformatter.dateFormat = "HH"
        Minformatter.dateFormat = "mm"
        
        CheckHourStart = Hourformatter.string(from: datePickerView.date)
        CheckMinStart = Minformatter.string(from: datePickerView.date)
        
        startTime.text = "예약시간(시작) : " + formatter.string(from: datePickerView.date)
    }
    
    @IBAction func endPicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        formatter.dateFormat = "HH:mm"
        Hourformatter.dateFormat = "HH"
        Minformatter.dateFormat = "mm"
        
        CheckHourEnd = Hourformatter.string(from: datePickerView.date)
        CheckMinEnd = Minformatter.string(from: datePickerView.date)
        
        endTime.text = "예약시간(끝) : " + formatter.string(from: datePickerView.date)
        
    }
    
    @IBAction func SelectDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd(EEE)"
        pickerDate.text = "날짜 : " + formatter.string(from: datePickerView.date)
    }
    
    @IBAction func OnSubmit(_ sender: UIButton) {
        
        TimeCheck()
        
    }
}

extension ReservePage  {
    
    func TimeCheck() {
        var hour = Int(CheckHourEnd)! - Int(CheckHourStart)! // 끝시간 - 시작시간
        var min = Int(CheckMinEnd)! - Int(CheckMinStart)! // 끝분 - 시작분
        
        hour = hour * 60 // 분으로 바꿈
        min = min + hour // 분으로 통합
        
        if min <= 120 && min >= 0{
            AlertSubmitError()
        } else if min < 0{
            AlertInputError()
        } else {
            // 올바른 조건이라면
            AlertSubmit()
        }
    }
    
    func AlertInputError() {
        let dialog = UIAlertController(title: "오류", message: "끝 시간이 시작 시간보다 빠릅니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        dialog.addAction(okAction)
        present(dialog, animated: true, completion: nil)
    }
    
    
    func AlertSubmitError(){
        let dialog = UIAlertController(title: "거부", message: "시작시간 - 끝시간이 2시간 이상 차이나야 합니다.  ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        dialog.addAction(okAction)
        present(dialog, animated: true, completion: nil)
    }
    
    
    func AlertSubmit() {
        let dialog = UIAlertController(title: "제출", message: "입력하신 정보가 맞으십니까?", preferredStyle: .alert)
        
        let contentVC = ListViewController()
        contentVC.StartTime = startTime.text ?? ""
        contentVC.EndTime = endTime.text ?? ""
        contentVC.PickerDate = pickerDate.text ?? ""
        dialog.setValue(contentVC, forKey: "contentViewController") // 커스텀추가 코드 - 프라이빗API
        
        let okAction = UIAlertAction(title: "제출", style: .default) {
            (_) in
            guard let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "VerifyPageVC") as? VerifyPage else {
                print("error")
                return
            }
            
            //MARK::: 여기에다가 사용자 예약정보 파베로 넘기는 코드 작성 - 일단 여기 로직이 실행되는건 로그인이 되어있다는 가정.
            self.ref = Database.database().reference() // 내 데이터베이스의 주소를 넣어준다.
            
            let user = Auth.auth().currentUser // 현재 유저 정보를 받아오고
            
            guard let key = self.ref.child("user").childByAutoId().key else {
                print("key err")
                return
            }
            print(key)
           
            let post = [
                        "speciality": "ad",
            ] as [String : Any]
            
            let childUpdates = ["user/\(user!.uid)/date": post["speciality"]]
            self.ref.updateChildValues(childUpdates)
            
            
            /*
             guard let key = ref.child("posts").childByAutoId().key else { return }
             let post = ["uid": userID,
                         "author": username,
                         "title": title,
                         "body": body]
             let childUpdates = ["/posts/\(key)": post,
                                 "/user-posts/\(userID)/\(key)/": post]
             ref.updateChildValues(childUpdates)
             */
            
            
            vc2.modalPresentationStyle = .fullScreen
            self.present(vc2, animated: false, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        dialog.addAction(okAction)
        dialog.addAction(cancelAction)
        
        present(dialog, animated: true, completion: nil)
    }
}

class ListViewController: UITableViewController {
    
    var StartTime : String = ""
    var EndTime : String = ""
    var PickerDate : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredContentSize.height = 220
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.row == 0 {
            cell.textLabel!.text = PickerDate
        } else if indexPath.row == 1 {
            cell.textLabel!.text = StartTime
            
        } else if indexPath.row == 2 {
            cell.textLabel!.text = EndTime
        }
       
        
        //cell.textLabel!.text = "\(indexPath.row)번째 옵션입니다."
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        
        return cell
    }
   
}
