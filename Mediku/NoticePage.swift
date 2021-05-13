//
//  NoticePage.swift
//  Medic
//
//  Created by Hamlit Jason on 2021/05/05.
//

import UIKit


class NoticePage : UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    
    var ResourceName = ["notice1","notice2"]
    var paramRow : Int = 0
    
    func sendData(data: Int) {
        paramRow = data
    }
    
    
    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        paramRow = Int(appDelegate!.paramIndex)

        print(paramRow)
        print(String(ResourceName[paramRow]))
        self.img.image = UIImage(named: String(ResourceName[paramRow]) + ".jpeg")
    }
}
