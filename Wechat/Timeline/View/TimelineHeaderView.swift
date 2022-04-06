//
//  TimelineHeaderView.swift
//  Wechat
//
//  Created by Jian on 2022/2/8.
//

import SwiftUI

struct TimelineHeaderView: View {
    @EnvironmentObject private var loginedMode: LoginedModelFromHomeView
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            AsyncImage(url: URL(string: loginedMode.profile.backgroundUrl)) { image in
                image.resizable()
            } placeholder: {
                Color.white
            }
            .scaledToFill()
            HStack {
                Text(loginedMode.profile.nickname)
                    .foregroundColor(.white)
                    .bold()
                AsyncImage(url: URL(string: loginedMode.profile.avatarUrl)) { image in
                    image.resizable()
                } placeholder: {
                    Color.white
                }
                .frame(width: 70, height: 70)
            }
            .offset(x: -15, y: 15)
        }
        .padding(EdgeInsets(top: 0,
                            leading: 0,
                            bottom: 20,
                            trailing: 0))
    }
}

struct TimelineHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        let loginedModel: LoginedModelFromHomeView = LoginedModelFromHomeView()
        return TimelineHeaderView()
            .environmentObject(loginedModel)
    }
}
