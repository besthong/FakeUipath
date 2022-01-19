//
//  ShowJobs.swift
//  FakeUipath
//
//  Created by 훈쓰 on 2022/01/18.
//

import Foundation
import UIKit

class ShowJobsViewController : UIViewController{
    @IBOutlet var testLabel: UILabel!
    var tempLabel: String = ""
    
    var user: User = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.text = tempLabel
    }
    
}
