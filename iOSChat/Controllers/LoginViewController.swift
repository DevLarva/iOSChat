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
        field.placeholder = "아이디"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50 ))
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("계속하기", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iOS Chat"
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(usernameField)
        view.addSubview(button)
        addConstraints()
        button.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        usernameField.becomeFirstResponder()
        
        if ChatManager.shared.isSignedIn {
            presentChatList(animated: false)
        }
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            usernameField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
            usernameField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
            usernameField.heightAnchor.constraint(equalToConstant: 50),
            
            button.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20),
            button.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 50),
            button.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -50),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func didTapContinue() {
        usernameField.resignFirstResponder()
        guard let text = usernameField.text, !text.isEmpty else {
            return
        }
        
        ChatManager.shared.signIn(with: text) { [weak self] success in
            guard success else {
                return
            }
            print("Did login")
            //Take user to chat list
            DispatchQueue.main.async {
                self?.presentChatList()
            }
        }
    }
    func presentChatList(animated: Bool = true) {
        print("Should show chat list")
        guard let vc = ChatManager.shared.createChannelList() else { return }
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapCompose))
        let tabVC = TabBarViewController(chatList: vc)
        tabVC.modalPresentationStyle = .fullScreen
        present(tabVC, animated: true)
    }
    @objc private func didTapCompose() {
        let alert = UIAlertController(title: "새로운 대화", message: "새로운 대화방 이름을 입력하세요", preferredStyle: .alert)
        
        
        alert.addTextField()
        alert.addAction(.init(title: "취소", style: .cancel))
        alert.addAction(.init(title: "생성", style: .default, handler: { _ in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else {
                return
            }
            DispatchQueue.main.async {
                ChatManager.shared.createNewChannel(name: text)    
            }
        }))
        
        presentedViewController?.present(alert, animated: true)
    }
}

