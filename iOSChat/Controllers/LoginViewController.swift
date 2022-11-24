//
//  ViewController.swift
//  iOSChat
//
//  Created by 백대홍 on 2022/11/24.
//

import UIKit

// MARK: - Login Screen
// MARK: - Channel List / Chats
// MARK: - Message
// MARK: - Create Chats/Channels
// MARK: - Settings (log out)
 

final class LoginViewController: UIViewController {

    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username..."
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50 ))
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iOS Chat"
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(usernameField)
        addConstraints()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        usernameField.becomeFirstResponder()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            usernameField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
            usernameField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
            usernameField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}

