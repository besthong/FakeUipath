//
//  User.swift
//  FakeUipath
//
//  Created by 훈쓰 on 2022/01/12.
//

import Foundation

// 유저 클래스 >👨🏻‍💻<
class User{
    static let shared = User()
    var id: String?
    var password: String?
    var accessToken: String?
    var idFromGetFolders: Int?
    
    private init() {}
    
//    init(id:String, password:String){
//        self.id = id
//        self.password = password
//    }
}
