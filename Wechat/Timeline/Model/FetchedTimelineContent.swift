//
//  FetchedTimelineContent.swift
//  Wechat
//
//  Created by weisite on 2022/4/6.
//

import Foundation

struct ImagesUrl: Codable {
    var url: String
}

struct Sender: Codable {
    var username: String
    var nick: String
    var avatar: String
}

struct Comment: Codable {
    var content: String
    var sender: Sender
}

struct FetchedTimelineContent: Codable {
    var id: Int
    var error: String?
    var unknownError: String?
    var content: String?
    var images: [ImagesUrl]?
    var sender: Sender?
    var comments: [Comment]?
    
    public enum CodingKeys: String, CodingKey {
        case unknownError = "unknown error"
        case id
        case error
        case content
        case images
        case sender
        case comments
    }
    
    public func mapToTimelineContent() -> TimelineContent? {
        var pharsed: TimelineContent? = nil
        if self.error == nil || self.unknownError == nil {
            var likes: [String] = []
            if comments != nil {
                comments?.forEach { comment in
                    likes.append(comment.sender.nick)
                }
            }
            if images != nil {
                let nickname = self.sender?.nick ?? ""
                let avatarUrl = self.sender?.avatar ?? ""
                let photo = self.images?.first?.url ?? ""
                let message = self.content ?? ""
                pharsed = TimelineContent(id: id, nickname: nickname, avatarUrl: avatarUrl, type: .singlePhoto(photo: photo, message: message), likes: likes)
            } else if content != nil {
                let nickname = self.sender?.nick ?? ""
                let avatarUrl = self.sender?.avatar ?? ""
                let message = self.content ?? ""
                pharsed = TimelineContent(id: id, nickname: nickname, avatarUrl: avatarUrl, type: .singleMessage(message: message), likes: likes)
            }
        }
        return pharsed
    }
}
