//
//  LoginedModelFromHomeView.swift
//  Wechat
//
//  Created by Jian on 2022/2/8.
//

import Foundation
import SwiftUI
import Combine

@MainActor final class LoginedModelFromHomeView: ObservableObject {
    @Published private(set) var profile: Profile
    private var subscriptions: Set<AnyCancellable> = .init()
    
    init() {
        self.profile = Profile(nickname: "", avatarUrl: "", backgroundUrl: "", username: "")
        let url = URL(string: "https://thoughtworks-mobile-2018.herokuapp.com/user/jsmith")
        URLSession.shared
            .dataTaskPublisher(for: url!)
            .map(\.data)
            .decode(type: Profile.self, decoder: JSONDecoder())
            .mapError { _ in
                WeChatError.fetchprofileError
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink { completion in
                
            } receiveValue: { profile in
                self.profile = Profile(nickname: profile.nickname, avatarUrl: profile.avatarUrl, backgroundUrl: profile.backgroundUrl, username: profile.username)
            }
            .store(in: &self.subscriptions)
    }
    
    func updateLoginedAvatarUrl(url: String) {
        profile = Profile(nickname: profile.nickname, avatarUrl: url, backgroundUrl: profile.backgroundUrl, username: profile.username)
    }
}
