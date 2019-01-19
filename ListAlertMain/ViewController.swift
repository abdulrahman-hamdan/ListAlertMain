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
       return contents.count
    }
    @IBOutlet weak var ltableviewla: UITableView!
     var get=[AnyObject]()
    var contents=[content](){
        didSet{
            ltableviewla.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! listcell
        let contents=self.contents[indexPath.row]
        cell.statusindicator.image=UIImage(named: "211716-64-2.png")
        cell.statuslbl.text=contents.status
        cell.ipaddress.text=contents.ipaddress
        cell.name.text=contents.name
        cell.subnetmask.text=contents.subnetmask
        cell.statuslbl.layer.cornerRadius=13
        cell.statuslbl.layer.masksToBounds=true
        cell.statuslbl.textAlignment = .center
       // tableView.reloadData()
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
 
       
        
        
        let user = "admin@boot.com"
        let password = "admin"
        

        let credential = URLCredential(user: user, password: password, persistence: .forSession)
        
      
        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        Manager.request("https://45.55.43.15:9090/api/machine?page=0&size=10", method: .get,headers: headers )
            .responseJSON { response in
                
                let result=response.result
                
                if let dict=result.value as? Dictionary<String,AnyObject>{
                    if let innerdict=dict["content"]{
                        
                                        self.get=innerdict as! [AnyObject]
                                        for index in 0...self.get.count-1{
                                            let contnt=content()
                                       var row = self.get[index]
                                        let name = row["name"]
                                        let ipAddress=row["ipAddress"]
                                            let status=row["status"]
                                            let deviceIPSubnetMask=row["ipSubnetMask"]
                                                contnt.status=status as? String
                                            contnt.ipaddress=ipAddress as? String
                                            contnt.name=name as? String
                                            contnt.subnetmask=deviceIPSubnetMask as? String
                                        print(ipAddress)
                                            self.contents.append(contnt)
                                    
                                        }
                                    }
                                }
                

              Manager.session.invalidateAndCancel()
        }
    }


}

