//
//  SchoolViewModel.swift
//  20180416-EladioAlvarezValle-NYCSchools
//
//  Created by Eladio Alvarez Valle on 4/17/19.
//  Copyright © 2019 Eladio Alvarez Valle. All rights reserved.
//

import Foundation
import UIKit

class SchoolViewModel {
    
    private var delegate : SchoolProtocol
    private var schools : [School]?
    private var sats : [Sat]? {
        
        didSet {
            //Refresh data when SATS is downloaded
            self.delegate.refreshData()
        }
    }
    
    /// Class initializator
    init(delegate : SchoolProtocol) {
        
        self.delegate = delegate
    }
    
    /// Fetch Data from Server
    /// - Parameters:
    ///     - handler: True for successful fetch
    func getData(handler : @escaping (Bool) -> ()) {
        
        //Fetch Schools
        let apiCaller = API_Caller(URL: URLS.highSchool.url(), httpMethodType: .GET, authenticationType: .None)
        
        apiCaller.callAPI(dataParameter: nil, customHeaders: ["X-App-Token": "RhI2r08uFStqJgImLGthsuLhu"]) {
            
            [unowned self] status, data, response in
            
            if let data_ = data as? Data {
                
                do {
                    
                    self.schools = try JSONDecoder().decode([School].self, from: data_)
                    
                    
                    //Fetch SATS
                    let apiCaller = API_Caller(URL: URLS.sat.url(), httpMethodType: .GET, authenticationType: .None)
                    
                    apiCaller.callAPI(dataParameter: nil, customHeaders: ["X-App-Token": "RhI2r08uFStqJgImLGthsuLhu"]) {
                        
                        [unowned self] status, data, response in
                        
        
                        if let data_ = data_ as Data? {
                            
                            do {
                                
                                let sats = try JSONDecoder().decode([Sat].self, from: data_)
                                
                                //Update UI
                                DispatchQueue.main.async {
                                    
                                        self.sats = sats
                                        handler(true)
                                    }
                                
                                
                            } catch {
                                print("Error School Data \(error)")
                                handler(false)
                            }
                        }
                    }
                    
                } catch {
                    print("Error SAT Data \(error)")
                    handler(false)
                }
            }
        }
 
        
    }
    
    //Get schools count
    /// - Returns: Number of schools
    func getSchools()-> Int {
        
        return self.schools?.count ?? 0
    }
    
    //Get school by index number
    /// -Parameter:
    ///     - index: Int
    /// -Returns: School
    func getSchool(index : Int) -> School {
        
        //Check if school exists
        guard let school = self.schools?[index] else {
            
            //If not exists create a default school
            return School(academicopportunities1: nil, academicopportunities2: nil, admissionspriority11: nil, admissionspriority21: nil, admissionspriority31: nil, attendance_rate: "", bbl: nil, bin: nil, boro: nil, borough: nil, building_code: nil, bus: "", census_tract: nil, city: "", code1: nil, community_board: nil, council_district: nil, dbn: "", directions1: nil, ell_programs: nil, extracurricular_activities: nil, fax_number: nil, finalgrades: nil, grade9geapplicants1: nil, grade9geapplicantsperseat1: nil, grade9gefilledflag1: nil, grade9swdapplicants1: nil, grade9swdapplicantsperseat1: nil, grade9swdfilledflag1: nil, grades2018: nil, interest1: "", latitude: nil, location: "Not defined", longitude: nil, method1: nil, neighborhood: nil, nta: nil, offer_rate1: nil, overview_paragraph: nil, pct_stu_enough_variety: nil, pct_stu_safe: nil, phone_number: "", primary_address_line_1: nil, program1: nil, requirement1_1: nil, requirement2_1: nil, requirement3_1: nil, requirement4_1: nil, requirement5_1: nil, school_10th_seats: nil, school_accessibility_description: nil, school_email: nil, school_name: "Not defined", school_sports: nil, seats101: nil, seats9ge1: nil, seats9swd1: nil, state_code: "", subway: nil, total_students: "", website: "", zip: "")
        }
        
        return school
        
    }
    
    /// Return SAT for school dbn
    /// - Parameters:
    ///     - dbn: Key to get Sat from school
    /// - Returns : Sat for school
    func getSAT(dbn : String) -> Sat {
     
        //Filter SAT by dbn, if does not exist send empty sat
        var sat = self.sats?.filter({ $0.dbn == dbn}).first ?? Sat(dbn: "", school_name: "", num_of_sat_test_takers: nil, sat_critical_reading_avg_score: "Not available", sat_math_avg_score: "Not available", sat_writing_avg_score: "Not available")
        return sat
    }
    
}
