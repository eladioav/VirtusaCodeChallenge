//
//  APIStructures.swift
//  20180416-EladioAlvarezValle-NYCSchools
//
//  Created by Eladio Alvarez Valle on 4/17/19.
//  Copyright © 2019 Eladio Alvarez Valle. All rights reserved.
//

import Foundation

struct School : Codable {
    
    var academicopportunities1 : String?
    var academicopportunities2 : String?
    var admissionspriority11 : String?
    var admissionspriority21 : String?
    var admissionspriority31 : String?
    var attendance_rate : String
    var bbl : String?
    var bin : String?
    var boro : String?
    var borough : String?
    var building_code : String?
    var bus : String
    var census_tract : String?
    var city : String
    var code1 : String?
    var community_board : String?
    var council_district : String?
    var dbn : String
    var directions1 : String?
    var ell_programs : String?
    var extracurricular_activities : String?
    var fax_number : String?
    var finalgrades : String?
    var grade9geapplicants1 : String?
    var grade9geapplicantsperseat1 : String?
    var grade9gefilledflag1 : String?
    var grade9swdapplicants1 : String?
    var grade9swdapplicantsperseat1 : String?
    var grade9swdfilledflag1 : String?
    var grades2018 : String?
    var interest1 : String
    var latitude : String?
    var location : String
    var longitude : String?
    var method1 : String?
    var neighborhood : String?
    var nta : String?
    var offer_rate1 : String?
    var overview_paragraph : String?
    var pct_stu_enough_variety : String?
    var pct_stu_safe : String?
    var phone_number : String
    var primary_address_line_1 : String?
    var program1 : String?
    var requirement1_1 : String?
    var requirement2_1 : String?
    var requirement3_1 : String?
    var requirement4_1 : String?
    var requirement5_1 : String?
    var school_10th_seats : String?
    var school_accessibility_description : String?
    var school_email : String?
    var school_name : String
    var school_sports : String?
    var seats101 : String?
    var seats9ge1 : String?
    var seats9swd1 : String?
    var state_code : String
    var subway : String?
    var total_students : String
    var website : String
    var zip: String
}

struct Sat : Codable {
    
    var dbn : String
    var school_name : String
    var num_of_sat_test_takers : String
    var sat_critical_reading_avg_score : String
    var sat_math_avg_score : String
    var sat_writing_avg_score : String
}
