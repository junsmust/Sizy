//
//  LoginWithEmail.swift
//  SizyApp
//
//  Created by 임명준 on 2020/05/02.
//  Copyright © 2020 임명준. All rights reserved.
//

import UIKit

class LoginWithEmailVC: UIViewController {
    
    private var keyboardHeight: CGFloat!
    
    private lazy var emailTextFd:UITextField! = UITextField().then({
        $0.placeholder = AppStrings.inputEmailPlaceHolder.rawValue
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
    })
    private lazy var viewBottomLine:UIView! = UIView().then({
        $0.backgroundColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
    })
    private lazy var alertLabel:UILabel! = UILabel().then({
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = AppStrings.inputEmailFormatLb.rawValue
        $0.textColor = .red
        $0.isHidden = true
    })
    private lazy var confirmBtn:UIButton = UIButton().then({
        $0.setTitle(AppStrings.confirmBtn.rawValue, for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    })
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(displayP3Red: 200, green: 200, blue: 200, alpha: 1.0)
        
        title = AppStrings.emailLogin.rawValue
        view.addSubview(emailTextFd)
        emailTextFd.delegate = self
        view.addSubview(viewBottomLine)
        view.addSubview(alertLabel)
        view.addSubview(confirmBtn)

        setupEmailTextFd()
        setupViewBottomLine()
        setupAlertLabel()
        setupConfirmBtn()
    }
    //check Email format
     func isValidEmailAddress(email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
            return emailTest.evaluate(with: email)
    }

    @objc func confirmEmailFormat(sender:UIButton){
        guard let email = emailTextFd.text else{return}
        
        if !email.isEmpty{
           let responseValidCehck = isValidEmailAddress(email: email)
            if !responseValidCehck{
                alertLabel.isHidden = false
                AlertMessage.alertMessage.defaulAlertDialog(msgTitle: "alert", msgMessage: "test", ok: "yes", no: "no", yesAction: {
                    debugPrint("hellop")
                }, noAction: nil, toView: self)
            }else{
                alertLabel.isHidden = true
                navigationController?.pushViewController(SignUpViewController(userEmail: email), animated: true)
            }
        }
    }
}
//setup constraint
extension LoginWithEmailVC{
    func setupEmailTextFd(){
           NSLayoutConstraint.activate([
               emailTextFd.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
               emailTextFd.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 70),
               emailTextFd.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
               emailTextFd.heightAnchor.constraint(equalToConstant: 60)
           ])
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardChhangeFrame(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
       }
       func setupViewBottomLine(){
           NSLayoutConstraint.activate([
               viewBottomLine.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
               viewBottomLine.topAnchor.constraint(equalTo: emailTextFd.bottomAnchor),
               viewBottomLine.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
               viewBottomLine.heightAnchor.constraint(equalToConstant: 1)
           ])
       }
       func setupAlertLabel(){
           NSLayoutConstraint.activate([
               alertLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
               alertLabel.topAnchor.constraint(equalTo: viewBottomLine.bottomAnchor,constant: 5),
               alertLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
               alertLabel.heightAnchor.constraint(equalToConstant: 30)
           ])
       }
    func setupConfirmBtn(){
        NSLayoutConstraint.activate([
            confirmBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            confirmBtn.widthAnchor.constraint(equalToConstant: view.frame.width),
            confirmBtn.heightAnchor.constraint(equalToConstant: 70),
            confirmBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        confirmBtn.addTarget(self, action: #selector(confirmEmailFormat(sender:)), for: .touchUpInside)
    }
}
//키보드
extension LoginWithEmailVC:UITextFieldDelegate{
    @objc func keyboardWillAppear(sender:Notification){
        if let keyBoardFrame: NSValue =
            sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyBoardRectangle = keyBoardFrame.cgRectValue
            keyboardHeight = keyBoardRectangle.height
        }
        //confirmBtn.frame.origin.y -= keyboardHeight
        confirmBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -keyboardHeight).isActive = true
    }
    @objc func keyboardWillDisappear(sender:NotificationCenter){
    }
    
    @objc func keyboardChhangeFrame(sender:Notification){
        if let keyBoardFrame: NSValue =
                   sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
                   let keyBoardRectangle = keyBoardFrame.cgRectValue
                   keyboardHeight = keyBoardRectangle.height
        }
        debugPrint("keyboardChhangeFrame")
        confirmBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
         //confirmBtn.frame.origin.y -= keyboardHeight
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //passwordTextField.resignFirstResponder()
        textField.resignFirstResponder() //텍스트필드 비활성화
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //confirmBtn.frame.origin.y -= keyboardHeight
        return true
    }
}
