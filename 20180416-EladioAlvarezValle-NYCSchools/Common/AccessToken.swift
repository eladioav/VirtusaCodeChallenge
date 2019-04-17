//
//  AccessToken.swift
//  20180416-EladioAlvarezValle-NYCSchools
//
//  Created by Eladio Alvarez Valle on 4/16/19.
//  Copyright © 2019 Eladio Alvarez Valle. All rights reserved.
//

import UIKit

class AccessToken {
    
    static let sharedInstance = AccessToken()
    let defaults = UserDefaults.standard
    let authorizationServerURL = ""
    let userNameAuthorizationServer = ""
    let passwordAuthorizationServer = ""
    
    var tokenType : String?
    var scope : String?
    
    var accessToken : String? {
        
        didSet {
            
            defaults.set(accessToken, forKey: "accessToken")
        }
        
    }
    
    var expiresIn : Double = 0 {
        
        didSet {
            
            self.accessTokenExpirationDate = NSDate().timeIntervalSince1970 + expiresIn
        }
    }
    
    private var accessTokenExpirationDate : Double = 0 {
        
        didSet {
            
            defaults.set(accessTokenExpirationDate, forKey: "accessTokenExpirationDate")
        }
    }
    
    
    
    private lazy var apiCaller : API_Caller! = {
        
        let apiCaller_ = API_Caller(URL: authorizationServerURL, httpMethodType: .POST, authenticationType: .Basic, username: userNameAuthorizationServer, password: passwordAuthorizationServer)
        return apiCaller_
        
    }()
    
    private init() {
        
        //  Get values from NSUser Default
        self.accessToken = defaults.string(forKey: "accessToken")
        self.accessTokenExpirationDate = defaults.double(forKey: "accessTokenExpirationDate")
    }
    
    /// Get access token from Authorization Server
    private func getAccessToken(handler : @escaping(Bool,String)->() ) {
        
        apiCaller.callAPI(dataParameter: nil) {
            
            (statusCode, data, response) in
            
            if statusCode == "200" { //Successful call
                
                do {
                    //Parse JSON from data received from server
                    let parsedResult = try JSONSerialization.jsonObject(with: (data as! Data?)!, options: .allowFragments)
                    
                    if let authorizationResponse = parsedResult as? [String : Any] {
                        
                        //Get access Token
                        if let accessToken_ = authorizationResponse["access_token"] as? String {
                            
                            self.accessToken = "Bearer " + accessToken_
                            
                        } else {
                            print("Access Token : No access token")
                            self.accessToken = nil
                            handler(false,"No Access token")
                            return // Exit function
                        }
                        
                        //Get expires in (seconds)
                        if let expiresIn_ = authorizationResponse["expires_in"] as? Double {
                            
                            self.expiresIn = expiresIn_
                            
                        } else {
                            print("Access Token : No expiration interval")
                            self.expiresIn = 0
                            handler(false,"No expiration interval")
                            return // Exit function
                        }
                        
                        //Get token type
                        if let tokenType_ = authorizationResponse["token_type"] as? String {
                            
                            self.tokenType = tokenType_
                            
                        } else {
                            
                            self.tokenType = nil
                        }
                        
                        
                        
                        //Get scope
                        if let scope_ = authorizationResponse["scope"] as? String {
                            
                            self.scope = scope_
                            
                        } else {
                            
                            self.scope = nil
                        }
                        
                        //No error getting parameters
                        handler(true,"OK")
                        
                    }
                    
                } catch {
                    
                    self.accessToken = nil
                    self.tokenType = nil
                    self.expiresIn = 0
                    self.scope = nil
                    print("Access Token : Error parsing result from Authorization server")
                    handler(false,"Error parsing result from Authorization server")
                }
                
                
            } else { //Call Error
                
                self.accessToken = nil
                self.tokenType = nil
                self.expiresIn = 0
                self.scope = nil
                print("Access Token : Error from authorization server : \(statusCode)")
                handler(false,"Error from authorization server : \(statusCode)")
            }
        }
    }
    
    /// Check if access token is valid
    /// - Parameters:
    ///     - handler : (isOk : Bool, errorMessage : String , accessToken : String)
    /// Returns : Seconds to token to expire
    func checkTokenExpiration(handler : @escaping(Bool, String, String)->() ) {
        
        let dateDiff = self.accessTokenExpirationDate - NSDate().timeIntervalSince1970 // Saved date - Today (in seconds)
        
        if dateDiff > 0 { //Token is still active
            
            print("Access Token : Active \(dateDiff) seconds : token : \(self.accessToken ?? "noToken")")
            handler(true, "OK",  self.accessToken == nil ? "" : self.accessToken!) //Return access token
            
        } else { //Token not active
            
            // Get access token from server
            self.getAccessToken() {
                
                (status,message) in
                
                if status { //Response is ok
                    
                    print("Access Token : Fetch token \(self.accessToken == nil ? "" : self.accessToken!) : \(self.accessTokenExpirationDate) secs")
                    handler(status, message, self.accessToken == nil ? "" : self.accessToken!) //Return access token
                    
                } else { //Error calling Authorization server
                    
                    print("Access Token : Error calling Authorization server")
                    handler(status, message,  "") //Return false,""
                }
            }
        }
        
        
    }
    
    /// Update Access Token directly
    func updateAccessToken(handler : @escaping(Bool,String)->()) {
        
        // Get access token from server
        self.getAccessToken() {
            
            (status,message) in
            
            if status { //Response is ok
                
                print("Access Token : OK updating Access token")
                handler(status, message)
                
            } else { //Error calling Authorization server
                
                print("Access Token : Error updating Access token")
                handler(status, message)
            }
        }
        
    }
    
}

