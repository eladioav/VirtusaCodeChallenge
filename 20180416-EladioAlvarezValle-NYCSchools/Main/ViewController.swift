//
//  ViewController.swift
//  20180416-EladioAlvarezValle-NYCSchools
//
//  Created by Eladio Alvarez Valle on 4/16/19.
//  Copyright © 2019 Eladio Alvarez Valle. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SchoolProtocol {

    @IBOutlet weak var tableView: UITableView!
    
    //View model instantiation
    lazy var viewModel : SchoolViewModel = {
       
        return SchoolViewModel(delegate: self)
    }()
    
    lazy var AIV : ActivityIndicatorView = {
        
        return ActivityIndicatorView(title: "Loading Data", center: CGPoint(x: UIScreen.main.bounds.width/2, y: 172 ))
    }()
    
    lazy var alert : UIAlertController = {
        
        var alert = UIAlertController(title: "Alert", message: "Error fetching data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.view.addSubview(self.AIV.getViewActivityIndicator())
        self.AIV.startAnimating()
        
        viewModel.getData {
            
            result in
            
            guard result else {
                
                self.present(self.alert, animated: true, completion: nil)
                return
            }
            
            self.AIV.stopAnimating()
            
        }
    }

    //MARK: Table View delegate methods implementation
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var sat = self.viewModel.getSAT(dbn: self.viewModel.getSchool(index: indexPath.row).dbn)
        print("SAT : \(sat)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.viewModel.getSchools()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let school = viewModel.getSchool(index: indexPath.row)
        cell.textLabel?.text = school.school_name
        cell.detailTextLabel?.text  = school.borough ?? "Not defined"
        cell.backgroundColor = indexPath.row%2 == 0 ? UIColor.lightText : UIColor.white
        return cell
    }
    
    //MARK: School Protocol implementation
    
    func refreshData() {
        
        self.tableView.reloadData()
    }
    
}

