//
//  TimelineContentView+ViewModel.swift
//  Wechat
//
//  Created by Jian on 2022/2/8.
//

import Foundation
import SwiftUI
import Combine

extension TimelineContentView {
    @MainActor final class ViewModel: ObservableObject {
        @Published private(set) var contents: [TimelineContent] = []
        private var subscriptions: Set<AnyCancellable> = .init()
        
        func loadData(profile: Profile) {
            contents.removeAll()
            let url = URL(string: "https://thoughtworks-mobile-2018.herokuapp.com/user/jsmith/tweets")
            URLSession.shared
                .dataTaskPublisher(for: url!)
                .map(\.data)
                .decode(type: [FetchedTimelineContent].self, decoder: JSONDecoder())
                .mapError { _ in
                    WeChatError.fetchTweetsError
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
                .sink { completion in
                    
                } receiveValue: { tweets in
                    for tweet in tweets {
                        let pharsed = tweet.mapToTimelineContent()
                        if (pharsed != nil) {
                            self.contents.append(pharsed!)
                        }
                    }
                }
                .store(in: &self.subscriptions)
        }
    }
}
