//
//  SignUpViewController.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 29/02/2024.
//

import UIKit

class SignUpViewController: UIViewController {
    struct Constants {
        static let cornerRadius : CGFloat = 8.0
    }
    
    private let usernameTextField : UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        
        // khi nhấn nút enter thì nó sẽ nảy sang ô field tiếp theo
        field.returnKeyType = .next
        
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        
        // cắt bỏ nội dung ở bên ngoài ranh giới layer
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    private let emailTextField : UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address"
        
        // khi nhấn nút enter thì nó sẽ nảy sang ô field tiếp theo
        field.returnKeyType = .next
        
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        
        // cắt bỏ nội dung ở bên ngoài ranh giới layer
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()

    private let passwordTextField : UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        
        // khi nhấn nút enter thì nó sẽ nảy sang ô field tiếp theo
        field.returnKeyType = .continue
        
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        
        // cắt bỏ nội dung ở bên ngoài ranh giới layer
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    private let RegisterButton : UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLayoutSubviews()
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(RegisterButton)
        RegisterButton.addTarget(self,
                                 action: #selector(registerButtonDidTapped),
                                 for: .touchUpInside)
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
    }
    override func viewDidLayoutSubviews() {
        usernameTextField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 10, width: view.width-40, height: 52)
        
        emailTextField.frame = CGRect(x: 20, y: usernameTextField.bottom + 10, width: view.width-40, height: 52)
        passwordTextField.frame = CGRect(x: 20, y: emailTextField.bottom + 10, width: view.width-40, height: 52)
        RegisterButton.frame = CGRect(x: 20, y: passwordTextField.bottom + 10, width: view.width-40, height: 52)
        
    }
    @objc private func registerButtonDidTapped(){
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let email = emailTextField.text, !email.isEmpty,
                let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text , !password.isEmpty , password.count >= 8 else {
            return
        }
        
        AuthManager.shared.registerUser(username: username, email: email, password: password){ success in
            DispatchQueue.main.async {
                if success {
                    // go
                } else {
                    //failed
                }
            }
                
        }
              
    }
}
extension SignUpViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            registerButtonDidTapped()
        }
        return true
    }
}
