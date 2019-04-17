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
    @IBOutlet weak var mainView: UIView!
    
    //MARK: View controller lyfe cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainView.layer.cornerRadius = 5.0
        
        if let sat_ = sat {
            
            self.schoolLabel.text = sat_.school_name
            self.mathLabel.text = sat_.sat_math_avg_score
            self.readingLabel.text = sat_.sat_critical_reading_avg_score
            self.writingLabel.text = sat_.sat_writing_avg_score
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
