//
//  DoctorList.swift
//  Medic
//
//  Created by Hamlit Jason on 2021/05/03.
//

import UIKit

class CellVO : UITableViewCell {
 
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var major: UILabel!
  
    @IBOutlet weak var detail: UILabel!
}

class DoctorList : UITableViewController {
    
    var list = [CellVO]() // 테이블 뷰를 구성할 리스트 데이터
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var subDoctorList = [DoctorData]() // 테이블 뷰를 위한 서브배열
    
    override func viewDidLoad() {
        // 화면이 처음 로드될 때
        
        
        if appDelegate?.callCheck == true {
            rowDecision()
            appDelegate?.callCheck = false
        } else {
            print("Call Done")
        }
        //print(appDelegate?.majorCountList)
        //print("\(appDelegate?.majorCountList[Int(appDelegate?.buttonidx ?? 0)])")
        //print(appDelegate?.SUMmajorCountList)
        //print(appDelegate?.DoctorList)
        subDecision()
        print(self.subDoctorList)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // 테이블 뷰 섹션의 갯수
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 몇 행으로 구성될 것인가?
        // 각 조건에 맞는 크기로 구성되어야 한다.
        return appDelegate?.majorCountList[Int(appDelegate?.buttonidx ?? 0)] ?? 0 // 우선은 1로 나중에 변경해야 함. - 테이블 뷰의 목록 길이
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 각 행의 내용은 어떻게 구성되는가
        
        //let row = self.list[indexPath.row] // 주어진 행에 맞는 데이터 소스를 읽어오기
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! CellVO // 테이블 셀 객체를 직접 생성하는 대신 큐로 가져옴
        let docimgName = self.subDoctorList[indexPath.row].doctorImage
        
        cell.img.image = (UIImage(named: String(docimgName!)) ?? UIImage(named: "no_docimg.PNG"))!
        cell.name.numberOfLines = 1
        cell.name.text =  self.subDoctorList[indexPath.row].name
        cell.detail.numberOfLines = 0 // 여러줄로 쓰기위해 LineBreak도 수정해주어야 함.
        cell.detail.text = self.subDoctorList[indexPath.row].Description
        cell.major.text = "[\(self.subDoctorList[indexPath.row].major!)]"
        
        return cell // 테이블 뷰의 인스턴스
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if appDelegate?.loginCheck == 1 { // 로그인이 된 상태이면
            RecieveDoctorList = subDoctorList[indexPath.row]
            print(type(of: subDoctorList[indexPath.row]))
            performSegue(withIdentifier: "ListSelectSegue", sender: self) // subDoctorList[indexPath.row]
        } else {
            let dialog = UIAlertController(title: "비회원", message: "로그인을 먼저 진행해주세요.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            dialog.addAction(okAction)
            present(dialog, animated: true, completion: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ListSelectSegue" {
            
            
        }
        
        
    }
    
    @IBAction func ButtonReserve(_ sender: UIButton) {
        print("asd")
    }
}


extension DoctorList {
    func rowDecision() {
        print("call rowDecision")
        
        let count : Int = (appDelegate?.DoctorList.count)!
        var sum = 0
        
        for i in 0...(count-1) {
            let major : String? = appDelegate?.DoctorList[i].major ?? "none"
            
            if major == "가정의학과" {
                appDelegate?.majorCountList[0] += 1
            } else if major == "산부인과" {
                appDelegate?.majorCountList[1] += 1
            } else if major == "성형외과" {
                appDelegate?.majorCountList[2] += 1
            } else if major == "소화기내과" {
                appDelegate?.majorCountList[3] += 1
            } else if major == "치과" {
                appDelegate?.majorCountList[4] += 1
            } else if major == "호흡기알레르기내과" {
                appDelegate?.majorCountList[5] += 1
            } else if major == "신경과" {
                appDelegate?.majorCountList[6] += 1
            } else if major == "소아청소년과" {
                appDelegate?.majorCountList[7] += 1
            } else if major == "재활의학과" {
                appDelegate?.majorCountList[8] += 1
            } else if major == "피부과" {
                appDelegate?.majorCountList[9] += 1
            } else if major == "정신건강의학과" {
                appDelegate?.majorCountList[10] += 1
            } else if major == "none" {
                print("none parser")
            } else {
                print("rowDecision default")
            }
 
        }
        
        for i in (appDelegate?.majorCountList)! {
            sum += i
            appDelegate?.SUMmajorCountList.append(sum)
        }
        
    }
    
    
    func subDecision() {
        let idx = Int(appDelegate?.buttonidx ?? 0)
        
        let start = Int(appDelegate?.SUMmajorCountList[idx] ?? 0)
        let end = Int(appDelegate?.SUMmajorCountList[idx+1] ?? 0)
        
        for i in start...end-1 {
            var element = [DoctorData]()
            element.insert((appDelegate?.DoctorList[i])!, at: 0)
            self.subDoctorList.append(contentsOf: element)
        }
        
    }
}
