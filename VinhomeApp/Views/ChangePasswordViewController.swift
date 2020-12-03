//
//  ChangePasswordViewController.swift
//  VinhomeApp
//
//  Created by Nguyen Vu on 03/12/2020.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChangePasswordViewController: UIViewController {
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let oldPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " Mật khẩu cũ "
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = .white
        return label
    }()
    
    let oldPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        textField.placeholder = "Nhập mật khẩu cũ"
        return textField
    }()
    
    let newPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " Mật khẩu mới "
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = .white
        return label
    }()
    
    let newPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        textField.placeholder = "Nhập mật khẩu mới"
        return textField
    }()
    
    let renewPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " Nhập lại mật khẩu mới "
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = .white
        return label
    }()
    
    let renewPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        textField.placeholder = "Nhập lại mật khẩu mới"
        return textField
    }()
    
    let confirmChangeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Đổi mật khẩu", for: .normal)
        button.backgroundColor = UIColor(red: 0.00, green: 0.59, blue: 0.53, alpha: 1.00)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(confirmChange), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupLayout()

        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.00, green: 0.59, blue: 0.53, alpha: 1.00)
        navigationItem.title = "Đổi mật khẩu"
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25),
                                                                    NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
        let backButton = UIBarButtonItem(title: "Quay lại", style: .done, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem = backButton
    }
    
    func addSubviews() {
        view.addSubview(containerView)
        containerView.addSubview(oldPasswordTextField)
        containerView.addSubview(newPasswordTextField)
        containerView.addSubview(renewPasswordTextField)
        containerView.addSubview(oldPasswordLabel)
        containerView.addSubview(newPasswordLabel)
        containerView.addSubview(renewPasswordLabel)
        containerView.addSubview(confirmChangeButton)
    }
    
    func setupLayout() {
        containerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        oldPasswordLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 50).isActive = true
        oldPasswordLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30).isActive = true
        
        oldPasswordTextField.topAnchor.constraint(equalTo: oldPasswordLabel.bottomAnchor, constant: -7).isActive = true
        oldPasswordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        oldPasswordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        oldPasswordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        newPasswordLabel.topAnchor.constraint(equalTo: oldPasswordTextField.bottomAnchor, constant: 20).isActive = true
        newPasswordLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30).isActive = true
        
        newPasswordTextField.topAnchor.constraint(equalTo: newPasswordLabel.bottomAnchor, constant: -7).isActive = true
        newPasswordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        newPasswordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        newPasswordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        renewPasswordLabel.topAnchor.constraint(equalTo: newPasswordTextField.bottomAnchor, constant: 20).isActive = true
        renewPasswordLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30).isActive = true
        
        renewPasswordTextField.topAnchor.constraint(equalTo: renewPasswordLabel.bottomAnchor, constant: -7).isActive = true
        renewPasswordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        renewPasswordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        renewPasswordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        confirmChangeButton.topAnchor.constraint(equalTo: renewPasswordTextField.bottomAnchor, constant: 20).isActive = true
        confirmChangeButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        confirmChangeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        confirmChangeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func confirmChange() {
        let oldpassword = oldPasswordTextField.text!
        let newpassword = newPasswordTextField.text!
        let renewpassword = renewPasswordTextField.text!
        
        if oldpassword == "" {
            let aler = UIAlertController(title: "Thông báo", message: "Vui lòng nhập mật khẩu hiện tại", preferredStyle: UIAlertController.Style.alert)
            aler.addAction(UIAlertAction(title: "Đóng", style: UIAlertAction.Style.default, handler: nil))
            self.present(aler, animated: true, completion: nil)
        }
        
        if newpassword == "" {
            let aler = UIAlertController(title: "Thông báo", message: "Vui lòng nhập mật khẩu mới", preferredStyle: UIAlertController.Style.alert)
            aler.addAction(UIAlertAction(title: "Đóng", style: UIAlertAction.Style.default, handler: nil))
            self.present(aler, animated: true, completion: nil)
        }
        
        if newpassword != renewpassword {
            let aler = UIAlertController(title: "Thông báo", message: "Mật khẩu mới và mật khẩu cũ không trùng khớp. Vui lòng nhập lại.", preferredStyle: UIAlertController.Style.alert)
            aler.addAction(UIAlertAction(title: "Đóng", style: UIAlertAction.Style.default, handler: nil))
            self.present(aler, animated: true, completion: nil)
        }
        
        changePassword(oldpassword, newpassword)
    }
    
    func changePassword(_ oldpassword: String, _ newpassword: String) {
        let url = "http://report.bekhoe.vn/api/accounts/changePassword"
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let header: HTTPHeaders = ["Authorization" : "Bearer \(token)",
                                   "Content-Type" : "application/x-www-form-urlencoded"]
        let params = ["oldpassword": oldpassword, "newpassword": newpassword]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: header).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = json["data"].stringValue
                if data == "true" {
                    let alert = UIAlertController(title: "Thông báo", message: "Bạn đã đổi mật khẩu thành công. Vui lòng đăng nhập lại.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Đóng", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
//                        let loginVC = LoginViewController()
//                        let navigationController = UINavigationController(rootViewController: loginVC)
//                        navigationController.modalPresentationStyle = .fullScreen
//                        self.present(navigationController, animated: true, completion: nil)
                        UserDefaults.standard.removeObject(forKey: "token")
                        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let loginVC = mainStoryboard.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let message = json["message"].stringValue
                    let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Đóng", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }
}
