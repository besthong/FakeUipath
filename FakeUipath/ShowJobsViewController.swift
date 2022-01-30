//
//  ShowJobs.swift
//  FakeUipath
//
//  Created by 훈쓰 on 2022/01/18.
//

import Foundation
import UIKit

class ShowJobsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    
    var user = User.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFolder()
    }
    
    struct folder: Codable {
        let odataContext: String?
        let odataCount: Int?
        let value: [Value]?

        enum CodingKeys: String, CodingKey {
            case odataContext = "@odata.context"
            case odataCount = "@odata.count"
            case value
        }
    }

    struct Value: Codable {
        let key, displayName, fullyQualifiedName, fullyQualifiedNameOrderable: String
        let valueDescription: String
        let provisionType, permissionModel: String
        let parentID, parentKey: String
        let isActive: Bool
        let feedType: String
        let id: Int

        enum CodingKeys: String, CodingKey {
            case key = "Key"
            case displayName = "DisplayName"
            case fullyQualifiedName = "FullyQualifiedName"
            case fullyQualifiedNameOrderable = "FullyQualifiedNameOrderable"
            case valueDescription = "Description"
            case provisionType = "ProvisionType"
            case permissionModel = "PermissionModel"
            case parentID = "ParentId"
            case parentKey = "ParentKey"
            case isActive = "IsActive"
            case feedType = "FeedType"
            case id = "Id"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{
            return UITableViewCell()
        }
        return cell
    }
    
    func getFolder(){
        let folderUrl = "https://cloud.uipath.com/koreaquewzby/KS_HJH/orchestrator_/odata/folders?Filter=ClassicFolder"

        let url = URL(string: folderUrl)
        var request = URLRequest(url:url!)
        // GET 호출시 헤더 포함해서 값 전달 👇🏼
        request.allHTTPHeaderFields=[
            "Authorization":user.accessToken ?? "",
        ]
        URLSession.shared.dataTask(with: request){(data,response,error)in
            guard let data = data else{return}
            print("data \(data)")
            do{
                let decodedData = try JSONDecoder().decode(folder.self, from: data)
                print(decodedData)
            }catch{print(String(describing: error))}
        }.resume()
    }
}
