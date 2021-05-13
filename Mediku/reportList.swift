//
//  reportList.swift
//  Medic
//
//  Created by Hamlit Jason on 2021/05/06.
//

import UIKit

class reportList : UITableViewController {
    
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
}
