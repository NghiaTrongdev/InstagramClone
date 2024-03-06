//
//  LoginViewController.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 29/02/2024.
//
import SafariServices
import UIKit

class LoginViewController: UIViewController {
    struct Constants {
        static let cornerRadius : CGFloat = 8.0
    }
    
    private let usernameTextField : UITextField = {
        let field = UITextField()
        field.placeholder = "Username or email"
        
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
    private let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let termButton : UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    private let privacyButton : UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy ", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    private let createButton : UIButton = {
        let button = UIButton()
        button.setTitle("Create new Account ?", for: .normal)
        button.setTitleColor(.label, for: .normal)
        
        return button
    }()
    private let headerView : UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView  = UIImageView (image: UIImage(named: "instabackground"))
        header.addSubview(backgroundImageView)
        return header
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(didloginButtonTapped), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(didCreatenewAccountButtonTapped), for: .touchUpInside)
        termButton.addTarget(self, action: #selector(didtermButtonTapped), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didprivacyButtonTapped), for: .touchUpInside)
        
        addSubview()
        view.backgroundColor = .systemBackground
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    private func addSubview(){
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(termButton)
        view.addSubview(privacyButton)
        view.addSubview(createButton)
        view.addSubview(headerView)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(x: 0, y:0, width: view.bounds.width, height: view.height / 3.0)
        
        usernameTextField.frame = CGRect(x: 25, y: headerView.bottom + 40, width: view.width - 50, height: 52.0)
        
        passwordTextField.frame = CGRect(x: 25, y: usernameTextField.bottom + 10, width: view.width - 50, height: 52.0)
        
        loginButton.frame = CGRect(x: 25, y: passwordTextField.bottom + 10, width: view.width - 50 , height: 52.0)
        
        createButton.frame = CGRect(x: 25, y: loginButton.bottom + 10, width: view.width - 50 , height: 52.0)
        
        termButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom - 100, width: view.width - 20, height: 50)
        
        privacyButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom - 50, width: view.width - 20, height: 50)
        configuareHeaderView()
    }
    private func configuareHeaderView(){
        guard headerView.subviews.count == 1 else {
            return
        }
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        
        let logoimageView = UIImageView(image: UIImage(named: "logotext"))
        logoimageView.contentMode = .scaleAspectFit
        headerView.addSubview(logoimageView)
        logoimageView.frame = CGRect(x: headerView.width/4.0,
                                     y: view.safeAreaInsets.top,
                                     width: headerView.width/2.0,
                                     height: headerView.height - view.safeAreaInsets.top)
    }
    @objc private func didloginButtonTapped(){
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let usernameEmail = usernameTextField.text, !usernameEmail.isEmpty ,
              let password = passwordTextField.text , !password.isEmpty , password.count >= 8 else {
            return
        }
        
        var username: String?
        var email : String?
        
        if usernameEmail.contains("@"), usernameEmail.contains("."){
            email = usernameEmail
            // email
        } else {
            username = usernameEmail
        }
        AuthManager.shared.loginUser(username: username, email: email, password: password){success in
            DispatchQueue.main.sync {
                if success {
                    self.dismiss(animated: true,completion: nil)
                } else {
                    let alert = UIAlertController(title: "Log the error", message: "Unable to login ", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel,handler: nil))
                    self.present(alert,animated: true )
                }
            }
            
        }
        
        
    }
    @objc private func didtermButtonTapped(){
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    @objc private func didprivacyButtonTapped(){
        guard let url = URL(string: "https://help.instagram.com/155833707900388") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    @objc private func didCreatenewAccountButtonTapped(){
        let vc = SignUpViewController()
        present(vc, animated: true)
    }
  
}
extension LoginViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // nếu người dùng ấn enter tại username thì sẽ nảy đến password field
        // còn nếu người udngf nhấn enter tại password thì sẽ = nhấn nút login
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            didloginButtonTapped()
        }
        return true
    }
}
