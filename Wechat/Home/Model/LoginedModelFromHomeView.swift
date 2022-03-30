//
//  LoginedModelFromHomeView.swift
//  Wechat
//
//  Created by Jian on 2022/2/8.
//

import Foundation
import SwiftUI

@MainActor final class LoginedModelFromHomeView: ObservableObject {
    @Published private(set) var profile: Profile = Profile(nickname: "桃子猪", avatarUrl: "timeline_profile_image", backgroundUrl: "timeline_profile_background")

    func updateLoginedAvatarUrl(url: String) {
        profile = Profile(nickname: profile.nickname, avatarUrl: url, backgroundUrl: profile.backgroundUrl)
    }
}
