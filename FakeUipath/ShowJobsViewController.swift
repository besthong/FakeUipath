//
//  ShowJobs.swift
//  FakeUipath
//
//  Created by ํ์ฐ on 2022/01/18.
//

import Foundation
import UIKit

class ShowJobsViewController : UIViewController{
    
    @IBOutlet var tableView: UITableView!
    
    var user = User.shared
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource=self
        getFolder()
        getEnv()
        print("Env id is -> \(user.idEnv)")
        getRobot()
        print(user.robotNames)
        //        tableView.reloadData()
    }
    
// ---getFplder API์ํ structure ๐๐ผ
    struct folder: Codable {
        let value: [Value]?

        enum CodingKeys: String, CodingKey {
            case value
        }
    }
    struct Value: Codable {
        let id: Int
        enum CodingKeys: String, CodingKey {
            case id = "Id"
        }
    }
    func getFolder(){
        let folderUrl = "https://cloud.uipath.com/koreaquewzby/##########"

        let url = URL(string: folderUrl)
        var request = URLRequest(url:url!)
        // GET ํธ์ถ์ ํค๋ ํฌํจํด์ ๊ฐ ์ ๋ฌ ๐๐ผ
        request.httpMethod="GET"
        request.setValue("Bearer \(user.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request){(data,response,error)in
            guard let data = data else{return}
//            print("data \(data)")
            do{
                let decodedData = try JSONDecoder().decode(folder.self, from: data)
                print(decodedData.value!)
                for i in decodedData.value!{
                    self.user.idFromGetFolders=i.id
                }
//                print("INPUT > : \(self.user.idFromGetFolders ?? 0)")
            }catch{print(String(describing: error))}
        }.resume()
    }
    // ---getFplder API์ํ structure๐๐ป
    
    // ---getEnv API ์ํ structure ๋ฐ API Call๐๐ผ
    struct env:Codable{
        let value:[valueOfEnv]
    }
    struct valueOfEnv:Codable{
        let name: String
        let id: Int
        
        enum CodingKeys: String, CodingKey{
            case name = "Name"
            case id = "Id"
        }
    }

    func getEnv(){
        let envUrl = "https://cloud.uipath.com/koreaquewzby/##########"
        let url = URL(string: envUrl)
        var request = URLRequest(url:url!)
        
        request.httpMethod = "GET"
        request.setValue(user.idFromGetFolders as? String, forHTTPHeaderField: "X-UIPATH-OrganizationUnitId")
        request.setValue("Bearer \(user.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request){(data,response,error)in
            guard let data = data else{return}
            
//            print("data \(data)")
            do{
                let decodedData = try JSONDecoder().decode(env.self, from: data)
                for i in decodedData.value{
                    self.user.idEnv = i.id
                }
//                completion(decodedData)
            }catch{print(String(describing:error))}
        }.resume()
    }
    // ---getEnv API ์ํ structure ๋ฐ API Call๐๐ป
    
    
    // ---getRobot API ์ํ structure ๋ฐ API Call๐๐ผ
    struct robot:Codable{
        let value: [valueOfRobot]
        
    }
    struct valueOfRobot:Codable{
        let name: String
//        let machineName: String
//        let machineID: Int
//        let name, username: String
//        let type, hostingType, provisionType: String
//        let userID: Int
//        let enabled: Bool
//        let robotEnvironments: String?
//        let lastModificationTime: String?
//        let lastModifierUserID: Int?
//        let creationTime: String
//        let creatorUserID, id: Int
        
        enum CodingKeys: String, CodingKey {
//            case machineName = "MachineName"
//            case machineID = "MachineId"
            case name = "Name"
//            case username = "Username"
//            case type = "Type"
//            case hostingType = "HostingType"
//            case provisionType = "ProvisionType"
//            case userID = "UserId"
//            case enabled = "Enabled"
//            case robotEnvironments = "RobotEnvironments"
//            case lastModificationTime = "LastModificationTime"
//            case lastModifierUserID = "LastModifierUserId"
//            case creationTime = "CreationTime"
//            case creatorUserID = "CreatorUserId"
//            case id = "Id"
            
        }
    }
    
    func getRobot(){
        let robotUrl = "https://cloud.uipath.com/########"
        let url = URL(string: robotUrl)
        var request = URLRequest(url:url!)
        
        request.httpMethod="GET"
        request.setValue(user.idFromGetFolders as? String, forHTTPHeaderField: "X-UIPATH-OrganizationUnitId")
        request.setValue("Bearer \(user.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request){[self](data,response,error)in
            guard let data = data else{return}
//            print("data \(data)")
            do{
                let decodedData = try JSONDecoder().decode(robot.self, from:data)
                print(decodedData)
                DispatchQueue.main.async{
                    for i in decodedData.value{
    //                    print(i.name)
//                        self.user.robotNames!.append(i.name)
                        (self.user.robotNames?.append(i.name)) ?? (self.user.robotNames = [i.name])
                    }
                }
            }catch{(print(String(describing: error)))}
        }.resume()
    }
    // ---getRobot API ์ํ structure ๋ฐ API Call๐๐ป
}


extension ShowJobsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.robotNames?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{
            return UITableViewCell()
        }
        return cell
    }
}
