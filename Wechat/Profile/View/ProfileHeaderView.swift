//
//  ProfileHeaderView.swift
//  Wechat
//
//  Created by Jian on 2022/2/8.
//

import SwiftUI

struct ProfileHeaderView: View {
    @EnvironmentObject private var loginedModel: LoginedModelFromHomeView
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: loginedModel.profile.avatarUrl)) { image in
                image.resizable()
            } placeholder: {
                Color.white
            }
            .frame(width: 60, height: 80)
            Text(loginedModel.profile.nickname)
                .padding(EdgeInsets(top: 4, leading: 4, bottom: 0, trailing: 4))
            Spacer()
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        let loginedModel: LoginedModelFromHomeView = LoginedModelFromHomeView()
        ProfileHeaderView()
            .environmentObject(loginedModel)
    }
}
