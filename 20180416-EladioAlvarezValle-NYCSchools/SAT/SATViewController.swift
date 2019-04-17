//
//  SATViewController.swift
//  20180416-EladioAlvarezValle-NYCSchools
//
//  Created by Eladio Alvarez Valle on 4/17/19.
//  Copyright © 2019 Eladio Alvarez Valle. All rights reserved.
//

import Foundation
import UIKit

class SATViewController : UIViewController {
    
    var sat : Sat?
    
    @IBOutlet weak var mathLabel: UILabel!
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var writingLabel: UILabel!
    @IBOutlet weak var schoolLabel: UILabel!
    
    //MARK: View controller lyfe cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}
