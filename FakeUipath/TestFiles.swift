//
//  TestFiles.swift
//  FakeUipath
//
//  Created by 훈쓰 on 2022/01/13.
//

import Foundation

// 키보드관련
//    //텍스트필드 입력시 키보드 올라가도록 >👨🏻‍💻<
//    override func viewWillAppear(_ animated: Bool) { self.addKeyboardNotifications() }
//    override func viewWillDisappear(_ animated: Bool) { self.removeKeyboardNotifications() }

//
//    func addKeyboardNotifications(){
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object:nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//
//    }
//    func removeKeyboardNotifications(){
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//    @objc func keyboardWillShow(_ noti: NSNotification){
//        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//            self.view.frame.origin.y -= (keyboardHeight-(self.tabBarController?.tabBar.frame.size.height)) }
//        }
//    @objc func keyboardWillHide(_ noti: NSNotification){
//        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//            self.view.frame.origin.y += (keyboardHeight-(self.tabBarController?.tabBar.frame.size.height ?? 0))
//
//
//        }
//    }

// 키보드관련
//    @objc private func adjustInputView(noti: Notification) {
//        guard let userInfo = noti.userInfo else { return }
//        // [X] TODO: 키보드 높이에 따른 인풋뷰 위치 변경
//        //실제 위치와 사이즈까지 알고있음
//        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
//            else { return}
//
//        if noti.name == UIResponder.keyboardWillShowNotification{
//            let adjustmentHeight = keyboardFrame.height - view.safeAreaInsets.bottom
//            inputViewBottom.constant = adjustmentHeight
//        } else{
//            inputViewBottom.constant = 0
//        }
//    }
