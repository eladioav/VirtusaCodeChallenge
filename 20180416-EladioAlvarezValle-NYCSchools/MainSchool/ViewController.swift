//
//  ViewController.swift
//  20180416-EladioAlvarezValle-NYCSchools
//
//  Created by Eladio Alvarez Valle on 4/16/19.
//  Copyright © 2019 Eladio Alvarez Valle. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SchoolProtocol {

    //MARK: Controls and vars instantiation
    
    @IBOutlet weak var tableView: UITableView!
    
    //View model instantiation
    lazy var viewModel : SchoolViewModel = {
       
        return SchoolViewModel(delegate: self)
    }()
    
    private let refreshControl = UIRefreshControl()

    lazy var AIV : ActivityIndicatorView = {
        
        return ActivityIndicatorView(title: "Loading Data", center: CGPoint(x: UIScreen.main.bounds.width/2, y: 172 ))
    }()
    
    lazy var alert : UIAlertController = {
        
        var alert = UIAlertController(title: "Alert", message: "Error fetching data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }()
    
    //MARK: View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            self.tableView.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        
        //Fetch data
        self.fetchData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
    }

    //MARK: Table View delegate methods implementation
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sat = self.viewModel.getSAT(dbn: self.viewModel.getSchool(index: indexPath.row).dbn)
        print("SAT : \(sat)")
        let satVC = self.storyboard?.instantiateViewController(withIdentifier: "SATViewController") as! SATViewController
        satVC.sat = sat
        self.present(satVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.viewModel.getSchools()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        self.setCell(index: indexPath.row, cell: cell)
        return cell
    }
    
    /// Set cell style and fill with data
    /// - Parameters:
    ///     - index : cell index row
    ///     - cell : Cell to setup
    func setCell(index : Int, cell : UITableViewCell) {
        
        let school = viewModel.getSchool(index: index)
        cell.textLabel?.text = school.school_name
        cell.textLabel?.textColor = index%2 == 0 ? UIColor.white : UIColor.darkGray
        cell.detailTextLabel?.text  = school.borough ?? "Not defined"
        cell.backgroundColor = index%2 == 0 ? UIColor.darkGray : UIColor.white
        
    }
    
    //MARK: Helper methods
    
    /// Fetch data
    @objc func fetchData() {
        
        self.view.addSubview(self.AIV.getViewActivityIndicator())
        self.AIV.startAnimating()
        
        viewModel.getData {
            
            result in
            
                //Stop animating and refreshing
                self.AIV.stopAnimating()
                self.refreshControl.endRefreshing()
            
                guard result else {
                
                    self.present(self.alert, animated: true, completion: nil)
                    return
                }
            
            
            
        }
    }
    
    //MARK: School Protocol implementation
    
    func refreshData() {
        
        self.tableView.reloadData()
    }
    
}

