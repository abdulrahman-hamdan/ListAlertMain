//
//  ViewController.swift
//  ListAlertMain
//
//  Created by Abood Hamdan on 1/16/19.
//  Copyright © 2019 Abood Hamdan. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! listcell
        cell.statusindicator.image=UIImage(named: "211716-64-2.png")
        cell.statuslbl.text="cpu100%"
        cell.ipaddress.text="182.99.2.2"
        cell.statuslbl.layer.cornerRadius=13
        cell.statuslbl.layer.masksToBounds=true
        cell.statuslbl.textAlignment = .center
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         var Manager : Alamofire.SessionManager = {
            // Create the server trust policies
            let serverTrustPolicies: [String: ServerTrustPolicy] = [
                "45.55.43.15": .disableEvaluation
            ]
            // Create custom manager
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
            let man = Alamofire.SessionManager(
                configuration: URLSessionConfiguration.default,
                serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
            )
            return man
        }()
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//         var manager: SessionManager?
//        // Import the certificates like xxx.cer to your project(anywhere will be fine), then the ServerTrustPolicy.certificatesInBundle() can find them
//        let serverTrustPolicy = ServerTrustPolicy.pinCertificates(
//            certificates: ServerTrustPolicy.certificates(),
//            validateCertificateChain: false,
//            validateHost: true
//        )
//        let serverTrustPolicies: [String : ServerTrustPolicy] = [
//            "mohamed.cer": .disableEvaluation, // because the certificates only add the main domain, so disable evaluation for subdomain
//            "45.55.43.15": .disableEvaluation, // the IP address for request data
//            "9090": serverTrustPolicy
//        ]
//        manager = SessionManager(serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
//
//        DispatchQueue.main.async {
//
//        Manager.request("https://45.55.43.15:9090/api/machine?page=0&size=10",method:.post).responseJSON{ (responseData) -> Void in
//            print(responseData)
//            let result=responseData.result
//            let dict=result.value as? Dictionary<String,AnyObject>
//            let name=dict!["name"] as? String
//            let ipaddress=dict!["ipAddress"] as? String
//            let status=dict!["status"] as? String
//            print(status)
//            print(ipaddress)
//            print(name)
//print(result)
//
//            Manager.session.invalidateAndCancel()
//
//            }}
        
        let headers: HTTPHeaders = [
            "Authorization":"admin@boot.com" ,
            "Accept": "application/json"
        ]
        
        
        Manager.request("https://45.55.43.15:9090/api/machine?page=0&size=10", headers: headers).responseJSON { responseData in
            print(responseData)
                        let result=responseData.result
                        let dict=result.value as? Dictionary<String,AnyObject>
                        let name=dict!["name"] as? String
                        let ipaddress=dict!["ipAddress"] as? String
                        let status=dict!["status"] as? String
                        print(status)
                        print(ipaddress)
                        print(name)
        Manager.session.invalidateAndCancel()
            
        }
        
    }


}

