//
//  ChatManager.swift
//  iOSChat
//
//  Created by 백대홍 on 2022/11/24.
//

import Foundation
import StreamChat
import StreamChatUI

final class ChatManager {
    static let shared = ChatManager()
    
    
    private var client: ChatClient!
    
    
    
    func setUp() {
        let client = ChatClient(config: .init(apiKey: .init("px6egm8j8zej")))
        self.client = client
    }
    
    // Authentication
    
    func signIn(with username: String, completion: @ escaping(Bool) -> Void) {
        
    }
    
    func signOut() {
        
    }
    var isSignedIn: Bool {
        return false
    }
    
    var currentUser: String? {
        return nil
        
    }
    // MARK: - ChannelList + Creation
    
    public func createChannelList() -> UIViewController {
        return UIViewController()
        
    }
    public func createChannelList(name:String) {
        
    }
}
