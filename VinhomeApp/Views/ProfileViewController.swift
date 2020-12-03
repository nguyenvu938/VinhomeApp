//
//  ProfileViewController.swift
//  VinhomeApp
//
//  Created by NguyenVu on 30/11/2020.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class ProfileViewController: UIViewController {
    var isFirst: Bool = true
    
    deinit {
        print("Huỷ ProfileViewController")
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderColor = UIColor(red: 0.00, green: 0.59, blue: 0.53, alpha: 1.00).cgColor
        imageView.layer.borderWidth = 5
        imageView.contentMode = .scaleAspectFill
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
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 5
        textField.placeholder = "Chưa có thông tin"
        return textField
    }()
    
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " Ngày sinh "
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = .white
        return label
    }()
    
    let birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 5
        textField.placeholder = "Chưa có thông tin"
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
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 5
        textField.placeholder = "Chưa có thông tin"
        return textField
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " Điện thoại "
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = .white
        return label
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 5
        textField.placeholder = "Chưa có thông tin"
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
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 5
        textField.placeholder = "Chưa có thông tin"
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setupLayout()
        getProfileData()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.00, green: 0.59, blue: 0.53, alpha: 1.00)
        navigationItem.title = "Tài khoản"
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25),
                                                                    NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
        let editButton = UIBarButtonItem(title: "Sửa", style: .done, target: self, action: #selector(goEdit))
        navigationItem.rightBarButtonItem = editButton
        
        let signoutButton = UIBarButtonItem(title: "Thoát", style: .done, target: self, action: #selector(goSignOut))
        navigationItem.leftBarButtonItem = signoutButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async { [self] in
            avatarImage.layer.cornerRadius = avatarImage.frame.size.height/2
            avatarImage.clipsToBounds = true
        }
    }
    
    func addSubviews() {
        view.addSubview(containerView)
        containerView.addSubview(avatarImage)
        containerView.addSubview(nameTextField)
        containerView.addSubview(nameLabel)
        containerView.addSubview(phoneTextField)
        containerView.addSubview(phoneLabel)
        containerView.addSubview(birthdayTextField)
        containerView.addSubview(birthdayLabel)
        containerView.addSubview(addressTextField)
        containerView.addSubview(addressLabel)
        containerView.addSubview(emailTextField)
        containerView.addSubview(emailLabel)
    }
    
    func setupLayout() {
        containerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        
        avatarImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 50).isActive = true
        avatarImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        avatarImage.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.3).isActive = true
        avatarImage.heightAnchor.constraint(equalTo: avatarImage.widthAnchor, multiplier: 1).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 50).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -7).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        birthdayLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        birthdayLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30).isActive = true
        
        birthdayTextField.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: -7).isActive = true
        birthdayTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        birthdayTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        birthdayTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 20).isActive = true
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
    }
    
    @objc func goSignOut() {
        UserDefaults.standard.removeObject(forKey: "token")
        
        if isFirst {
            // Nếu chưa có màn login trước đó, thì khởi tạo và show lên màn login
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = mainStoryboard.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        } else {
            // Nếu đã có màn login trước đó, thì dismiss về màn login
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func goEdit(){
            let editVC = EditProfileViewController()
            navigationController?.pushViewController(editVC, animated: true)
    }
    
    func getProfileData() {
        let url = "http://report.bekhoe.vn/api/accounts/profile"
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let header: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { [weak self] response in
            guard let strongSelf = self else {return}
            switch response.result{
            case .success(let value):
                DispatchQueue.main.async {
                    let json = JSON(value)
                    let code = json["code"].intValue
                    if code == 0 {
                        let data = User(json["data"])
                        strongSelf.nameTextField.text = data.name
                        strongSelf.birthdayTextField.text = data.dateOfBirth
                        strongSelf.addressTextField.text = data.address
                        strongSelf.phoneTextField.text = data.phoneNumber
                        strongSelf.emailTextField.text = data.email
                        if data.avatar == "" {
                            strongSelf.avatarImage.image = UIImage(named: "logo")
                        } else{
                            let url = "http://report.bekhoe.vn" + data.avatar!
                            strongSelf.avatarImage.kf.setImage(with: URL(string: url))
                        }
                    } else {
                        let message = json["message"].stringValue
                        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Đóng", style: UIAlertAction.Style.default, handler: nil))
                        strongSelf.present(alert, animated: true, completion: nil)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

