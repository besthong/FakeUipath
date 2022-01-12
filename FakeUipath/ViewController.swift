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
        

        // Do any additional setup after loading the view.
    }
    
    //텍스트필드 입력시 키보드 올라가도록 >👨🏻‍💻<
    override func viewWillAppear(_ animated: Bool) { self.addKeyboardNotifications() }
    override func viewWillDisappear(_ animated: Bool) { self.removeKeyboardNotifications() }


    //유저 클래스 생성 >👨🏻‍💻<
    var user: User = .init()
    
    
    //뷰컨 클릭시 키보드가 내려가도록 설정 >👨🏻‍💻<
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func addKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        

    }
    func removeKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(_ noti: NSNotification){
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y -= (keyboardHeight-(self.tabBarController?.tabBar.frame.size.height)!) }
        }
    @objc func keyboardWillHide(_ noti: NSNotification){
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y += (keyboardHeight-(self.tabBarController?.tabBar.frame.size.height)!)
            
        
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
    }
}

