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
//    var idFromGetFolders: Array<Int>?
    var idFromGetFolders: Int?      // 테넌트에서 폴더 반환하는 id값
    var idEnv: Int?                // 테넌트에서 각 폴더 별 env 반환하는 id값
    var robotNames: [String]=[]
    private init() {}
    
//    init(id:String, password:String){
//        self.id = id
//        self.password = password
//    }
}
