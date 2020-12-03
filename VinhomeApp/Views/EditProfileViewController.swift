//
//  EditProfileViewController.swift
//  VinhomeApp
//
//  Created by NguyenVu on 30/11/2020.
//

import UIKit
import Alamofire
import SwiftyJSON
import Photos
import Kingfisher

class EditProfileViewController: UIViewController {
    deinit {
        print("Huỷ EditViewController")
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
    
    let cameraImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "camera.circle.fill")
        imageView.backgroundColor = .white
        imageView.tintColor = UIColor(red: 0.00, green: 0.59, blue: 0.53, alpha: 1.00)
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
        return textField
    }()
    
    let changePasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Đổi mật khẩu", for: .normal)
        button.backgroundColor = UIColor(red: 0.00, green: 0.59, blue: 0.53, alpha: 1.00)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Lưu", for: .normal)
        button.backgroundColor = UIColor(red: 0.00, green: 0.59, blue: 0.53, alpha: 1.00)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(goUpdate), for: .touchUpInside)
        return button
    }()
    
    var imagePicker: UIImagePickerController!
    var imagePath = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setupLayout()
        getProfileData()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.00, green: 0.59, blue: 0.53, alpha: 1.00)
        navigationItem.title = "Cập nhật thông tin"
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25),
                                                                    NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
        let backButton = UIBarButtonItem(title: "Quay lại", style: .done, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem = backButton
        
        let avatarTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectedImage))
        let cameraTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectedImage))
        avatarImage.addGestureRecognizer(avatarTapGesture)
        cameraImage.addGestureRecognizer(cameraTapGesture)
        avatarImage.isUserInteractionEnabled = true
        cameraImage.isUserInteractionEnabled = true
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        avatarImage.layer.cornerRadius = avatarImage.frame.size.height/2
        avatarImage.clipsToBounds = true
        cameraImage.layer.cornerRadius = cameraImage.frame.size.height/2
        cameraImage.clipsToBounds = true
    }
    
    func addSubviews() {
        view.addSubview(containerView)
        containerView.addSubview(avatarImage)
        containerView.addSubview(nameTextField)
        containerView.addSubview(nameLabel)
        containerView.addSubview(birthdayTextField)
        containerView.addSubview(birthdayLabel)
        containerView.addSubview(addressTextField)
        containerView.addSubview(addressLabel)
        containerView.addSubview(emailTextField)
        containerView.addSubview(emailLabel)
        containerView.addSubview(saveButton)
        containerView.addSubview(cameraImage)
        containerView.addSubview(changePasswordButton)
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
        
        cameraImage.bottomAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: -5).isActive = true
        cameraImage.trailingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: -5).isActive = true
        cameraImage.widthAnchor.constraint(equalTo: avatarImage.widthAnchor, multiplier: 0.3).isActive = true
        cameraImage.heightAnchor.constraint(equalTo: cameraImage.widthAnchor, multiplier: 1).isActive = true
        
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
        
        emailLabel.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: -7).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        changePasswordButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        changePasswordButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        changePasswordButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        changePasswordButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        saveButton.topAnchor.constraint(equalTo: changePasswordButton.bottomAnchor, constant: 20).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
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
                        strongSelf.emailTextField.text = data.email
                        if data.avatar != "" {
                            let url = "http://report.bekhoe.vn" + data.avatar!
                            strongSelf.avatarImage.kf.setImage(with: URL(string: url))
                        } else {
                            strongSelf.avatarImage.image = UIImage(named: "logo")
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
    
    @objc func goUpdate() {
        let url = "http://report.bekhoe.vn/api/accounts/update"
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let header: HTTPHeaders = ["Authorization" : "Bearer \(token)",
                                   "Content-Type" : "application/x-www-form-urlencoded"]
        let params = ["name": String(nameTextField.text!), "dateOfBirth": String(birthdayTextField.text!), "address": String(addressTextField.text!), "email": String(emailTextField.text!), "avatar": imagePath]
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: header).responseJSON { [self] response in
            switch response.result {
            case .success(_):
                let alert = UIAlertController(title: "Chúc mừng", message: "Bạn đã cập nhật thông tin thành công.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Đóng", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                    let profileVC = ProfileViewController()
                    navigationController?.pushViewController(profileVC, animated: true)
                }))
                present(alert, animated: true, completion: nil)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    @objc func changePassword() {
        let changePasswordVC = ChangePasswordViewController()
        let navigation = UINavigationController(rootViewController: changePasswordVC)
        self.present(navigation, animated: true, completion: nil)
    }
    
    @objc func selectedImage() {
        let alert = UIAlertController(title: "My App", message: "Chọn ảnh từ", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
        let camera = UIAlertAction(title: "Máy ảnh", style: .default, handler: { (_) in
            self.fromCamera(self.imagePicker, target: self)
        })
        let libray = UIAlertAction(title: "Thư viện", style: .default, handler: { (_) in
            self.fromLibrary(self.imagePicker, target: self)
        })
        
        alert.addAction(camera)
        alert.addAction(libray)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func confirm(message: String, viewController: UIViewController?, success: @escaping () -> Void){
        let alert = UIAlertController(title: "Vinhome App", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            success()
        }
        alert.addAction(action)
        
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    func setting(){
        let message = "App cần truy cập máy ảnh và thư viện của bạn. Ảnh của bạn sẽ không được chia sẻ khi chưa được phép của bạn."
        confirm(message: message, viewController: self) {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(settingsUrl)
                }
            }
        }
    }
    
    func fromLibrary(_ imagePicker: UIImagePickerController, target vc: UIViewController){
        func choosePhoto(){
            DispatchQueue.main.async {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                imagePicker.modalPresentationStyle = .popover
                vc.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        // khai báo biến để lấy quyền truy cập
        let status = PHPhotoLibrary.authorizationStatus()
        if (status == PHAuthorizationStatus.authorized) {
            // quyền truy cập đã được cấp
            choosePhoto()
        }else if (status == PHAuthorizationStatus.denied) {
            // quyền truy cập bị từ chối
            setting()
        }else if (status == PHAuthorizationStatus.notDetermined) {
            // quyền truy cập chưa được xác nhận
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                if (newStatus == PHAuthorizationStatus.authorized) {
                    choosePhoto()
                }else {
                    print("Không được cho phép truy cập vào thư viện ảnh")
                    DispatchQueue.main.async {
                        self.setting()
                    }
                }
            })
        }else if (status == PHAuthorizationStatus.restricted) {
            // Truy cập bị hạn chế, thông thường sẽ không xảy ra
            setting()
        }
    }
    
    func fromCamera(_ imagePicker: UIImagePickerController, target vc: UIViewController){
        func takePhoto(){
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                DispatchQueue.main.async {
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = UIImagePickerController.SourceType.camera
                    imagePicker.cameraCaptureMode = .photo
                    imagePicker.cameraDevice = .front
                    imagePicker.modalPresentationStyle = .fullScreen
                    vc.present(imagePicker, animated: true,completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Thông báo", message: "Không tìm thấy máy ảnh", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        //Camera
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                takePhoto()
            } else {
                print("camera denied")
                self.setting()
            }
        }
    }
    
    func upload(image: UIImage, success: @escaping (String)->(), failure: @escaping (String)->()){
        
        // tạo một hàm body request
        func createBody(boundary: String,
                        data: Data,
                        mimeType: String,
                        filename: String) -> Data {
            let body = NSMutableData()
            
            let boundaryPrefix = "--\(boundary)\r\n"
            
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
            body.appendString("Content-Type: \(mimeType)\r\n\r\n")
            body.append(data)
            body.appendString("\r\n")
            body.appendString("--".appending(boundary.appending("--")))
            
            return body as Data
        }
        
        // url
        var request  = URLRequest(url: URL(string:"http://report.bekhoe.vn/api/upload")!)
        
        // method
        request.httpMethod = "POST"
        
        //
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // header
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        request.allHTTPHeaderFields = ["Authorization": "Bearer \(token)"]
        
        // truyền dữ liệu vào body
        request.httpBody = createBody(boundary: boundary,
                                      data: image.jpegData(compressionQuality: 0.1)!,
                                      mimeType: "image/jpeg",
                                      filename: "image.jpg")
        
        // tạo một dataTask, với nhiệm vụ là gửi request, dữ liệu trả về là data, response và error
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            DispatchQueue.main.async {
                let json = JSON(data!)
                let code = json["code"].intValue
                if code == 0 {
                    if let dataImage = Avatar(json["data"]), let path = dataImage.path {
                        success(path)
                        self.imagePath = path
                    }
                } else {
                    failure(json["message"].stringValue)
                }
            }
        })
        
        // gọi resume để chạy hàm dataTask
        dataTask.resume()
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("error: \(info)")
            return
        }
//        self.avatarImageView.image = selectedImage
        upload(image: selectedImage, success: { (url) in
            self.avatarImage.kf.setImage(with: URL(string: "http://report.bekhoe.vn" + url))
        }) { (error) in
            print(error)
        }
        dismiss(animated: true, completion: nil)
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
