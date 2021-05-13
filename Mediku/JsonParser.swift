//
//  JsonParser.swift
//  Medic
//
//  Created by Hamlit Jason on 2021/05/07.
//

import UIKit

struct DoctorData {
    var major : String?
    var name : String?
    var Description : String?
    var doctorImage : String?
    var longDoctorImage : String?
}

class JsonParser {
    
    var list = [String]()


    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    
    func readJson() -> [DoctorData] {
        
        print("first")
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            print("else")
            return []
        }
        //print(path)
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            //print(data)
            let dict = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            //print(dict)
            
            let konkuk = dict["konkuk"] as! NSDictionary
            let speciality = konkuk["speciality"] as! NSDictionary
            let doctor = speciality["doctor"] as! NSArray
            
            for row in doctor {
                let r = row as! NSDictionary
                
                var bucket = DoctorData()
                bucket.major = r["major"] as? String ?? "err major"
                bucket.name = r["name"] as? String ?? "err DoctorName"
                bucket.Description = r["description"] as? String ?? "err Description"
                let docimg = String(r["major"] as? String ?? "") + "_" + String(r["name"] as? String ?? "") + ".PNG"
                bucket.doctorImage = docimg
                let longDocImg = String(r["major"] as? String ?? "") + "(A)_" + String(r["name"] as? String ?? "") + ".PNG"
                bucket.longDoctorImage = longDocImg
                
                //bucket.doctorImage = docimg as? String ?? "err doctorimg"
                appDelegate?.DoctorList.append(bucket)
            }
            //print(appDelegate?.DoctorList[0])
            //print(appDelegate?.DoctorList.count)
      
            
        } catch {
            NSLog("Parsing Error : \(error.localizedDescription)")
        }
        
    return[]
    }
    
}
