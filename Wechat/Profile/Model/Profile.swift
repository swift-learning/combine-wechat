//
//  Profile.swift
//  Wechat
//
//  Created by Jian on 2022/2/8.
//

import Foundation

struct Profile: Codable {
    var nickname: String
    var avatarUrl: String
    var backgroundUrl: String
    var username: String
    
    public enum CodingKeys: String, CodingKey {
        case backgroundUrl = "profile-image"
        case avatarUrl = "avatar"
        case nickname = "nick"
        case username
    }
}
