//
//  RegisterViewController.swift
//  VinhomeApp
//
//  Created by Nguyen Vu on 03/12/2020.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterViewController: UIViewController {
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " Họ tên "
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = .white
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Nhập họ tên"
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " Mật khẩu "
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = .white
        return label
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Nhập mật khẩu"
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let repasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " Nhập lại mật khẩu "
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = .white
        return label
    }()
    
    let repasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Nhập lại mật khẩu"
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " Địa chỉ "
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = .white
        return label
    }()
    
    let addressTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Nhập địa chỉ"
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " Số điện thoại "
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = .white
        return label
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Nhập số điện thoại"
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " Email "
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = .white
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Nhập email"
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Đăng ký", for: .normal)
        button.backgroundColor = UIColor(red: 0.00, green: 0.59, blue: 0.53, alpha: 1.00)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(goRegister(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setupLayout()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.00, green: 0.59, blue: 0.53, alpha: 1.00)
        navigationItem.title = "Đăng ký"
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25),
                                                                    NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
        let backButton = UIBarButtonItem(title: "Quay lại", style: .done, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem = backButton
    }

    func addSubviews() {
        view.addSubview(containerView)
        containerView.addSubview(avatarImage)
        containerView.addSubview(nameTextField)
        containerView.addSubview(nameLabel)
        containerView.addSubview(phoneTextField)
        containerView.addSubview(phoneLabel)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(passwordLabel)
        containerView.addSubview(repasswordTextField)
        containerView.addSubview(repasswordLabel)
        containerView.addSubview(addressTextField)
        containerView.addSubview(addressLabel)
        containerView.addSubview(emailTextField)
        containerView.addSubview(emailLabel)
        containerView.addSubview(registerButton)
    }
    
    func setupLayout() {
        containerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        
        avatarImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30).isActive = true
        avatarImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        avatarImage.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.3).isActive = true
        avatarImage.heightAnchor.constraint(equalTo: avatarImage.widthAnchor, multiplier: 1).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 30).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -7).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: -7).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        repasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        repasswordLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30).isActive = true
        
        repasswordTextField.topAnchor.constraint(equalTo: repasswordLabel.bottomAnchor, constant: -7).isActive = true
        repasswordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        repasswordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        repasswordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: repasswordTextField.bottomAnchor, constant: 20).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30).isActive = true
        
        addressTextField.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: -7).isActive = true
        addressTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        addressTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        addressTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        phoneLabel.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20).isActive = true
        phoneLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30).isActive = true
        
        phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: -7).isActive = true
        phoneTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        phoneTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        phoneTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: -7).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        registerButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        registerButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func goRegister(_ sender: Any) {
        let name = self.nameTextField.text!
        let password = self.passwordTextField.text!
        let repassword = self.repasswordTextField.text!
        let phone = self.phoneTextField.text!
        let address = self.addressTextField.text!
        let email = self.emailTextField.text!
        
        if name == "" || password == "" || address == "" || phone == "" || email == "" {
            let alert = UIAlertController(title: "Thông báo", message: "Vui đầy đủ tất cả thông tin.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Đóng", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if password != repassword {
            let alert = UIAlertController(title: "Thông báo", message: "Mật khẩu nhập không trùng khớp. Vui lòng nhập lại", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Đóng", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            register(name, password, address, phone, email)
        }
    }
    
    func register(_ name: String, _ password: String, _ address: String, _ phone: String, _ email: String) {
        let url = "http://report.bekhoe.vn/api/accounts/Register"
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        let params = ["name": name, "password": password, "address": address, "phonenumber": phone, "email": email]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let code = json["code"].intValue
                if code == 0 {
                    let data = User(json["data"])
                    UserDefaults.standard.removeObject(forKey: "token")
                    if let token = data.token {
                        UserDefaults.standard.setValue(token, forKey: "token")
                        UserDefaults.standard.setValue(password, forKey: "password")
                        let alert = UIAlertController(title: "Thông báo", message: "Bạn đã đăng ký thành công.", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Đóng", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                            if !token.isEmpty {
                                let profileVC = ProfileViewController()
                                self.navigationController?.pushViewController(profileVC, animated: true)
                            }
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    let message = json["message"].stringValue
                    let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Đóng", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
