//
//  ViewController.swift
//  FakeUipath
//
//  Created by 훈쓰 on 2022/01/11.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate=self // 델리게이트 설정
        overrideUserInterfaceStyle = .light // 다크모드 없애기
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputViewShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputViewHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    //유저 클래스 생성 >👨🏻‍💻<
    var user: User = .init()
    
    //뷰컨 클릭시 키보드가 내려가도록 설정 >👨🏻‍💻<
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // 키보드 올라오면 키보드 크기 계산해서 크기만큼 뷰 올리기 >👨🏻‍💻<
    @objc func adjustInputViewShow(noti: Notification){
        guard let userInfo = noti.userInfo else { return }
        if let keyboardsize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardsize.height
            }
        }
    }

    // 키보드 올라온 후 다른 곳 클릭 시 키보드 크기 계산해서 크기만큼 뷰 내리기 >👨🏻‍💻<
    @objc func adjustInputViewHide(noti: Notification){
        guard let userInfo = noti.userInfo else {return}
        if let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
    }
    
    //이메일 텍스트란 return 이벤트 발생시 아래 함수 실행 >👨🏻‍💻<
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.idTextField{
            user.id = textField.text
            print(user.id ?? "no input")
            //👇🏼요 함수는 리턴값 받을때 다음 텍스트필드에 커서 두도록 함 >👨🏻‍💻<
            passwordTextField.becomeFirstResponder()
            } else {
                passwordTextField.resignFirstResponder()
            }
        return true
    }
    
    // 로그인 버튼 클릭시 user 클래스에 입력된 Id,pwd 값 전달 >👨🏻‍💻<
    @IBAction func LoginBtn(_ sender: UIButton) {
        user.id = idTextField.text
        user.password = passwordTextField.text
        print("User ID \(user.id) and Password is\(user.password)")
        
        let refresh_token: String = "ju677Y9oUQJ5uTbwbfEb5ZQSph26s1ixvIcDCxE_HuPy0"
        let client_id: String = "8DEv1AMNXczW3y4U15LL3jYf62jK93n5"
        let grant_type: String = "refresh_token"
        
        let param = ["grant_type" : grant_type, "client_id" : client_id, "refresh_token" : refresh_token]
        let paramData = try! JSONSerialization.data(withJSONObject: param, options:[])
        
        let url = URL(string: "https://account.uipath.com/oauth/token")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("KS_HJH", forHTTPHeaderField: "X-UIPATH-TenantName")
        request.setValue(String(paramData.count), forHTTPHeaderField: "Content-Length")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let e = error{
                print("An Error has occured: \(e.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async(){
                do{
                    let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    guard let jsonObject = object else { return }
                    
                    let access_token = jsonObject["access_token"] as? String
                    let id_token = jsonObject["id_token"] as? String
                    let scope = jsonObject["scope"] as? String
                    let expires_in = jsonObject["expires_in"] as? String
                    let token_type = jsonObject["token_type"] as? String
                    
                    print(access_token ?? "nothing")
                    
                }catch let e as NSError{
                    print("An error has occured while parsing JSONObject: \(e.localizedDescription)")
                }
            }
        }.resume()
    }
}

