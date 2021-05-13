//
//  eventList.swift
//  Medic
//
//  Created by Hamlit Jason on 2021/05/07.
//

import UIKit

class eventCell : UITableViewCell {
    @IBOutlet weak var eventListImg: UIImageView!
}

class eventList : UITableViewController {
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! eventCell
        cell.eventListImg.image = UIImage(named: "event01.jpeg")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "EventSegue", sender: self)
        }
    }
}
