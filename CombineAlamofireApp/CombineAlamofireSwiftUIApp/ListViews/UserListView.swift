//
//  UserListView.swift
//  CombineAlamofireSwiftUIApp
//
//  Created by Michael A. Crawford on 6/14/21.
//

import CombineAlamofire
import SwiftUI

struct UserListView: View {
    @EnvironmentObject private var userList: ElementList<JPUser>

    var body: some View {
        NavigationView {
            List {
                ForEach(userList.elements) { user in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("#\(user.id.rawValue)").font(.caption)
                            Spacer()
                            Text(user.email.rawValue).font(.caption)
                        }
                        Text(user.username)
                            .font(.title3)
                            .padding(.top, 3.0)
                        Text(user.website?.absoluteString ?? "").font(.body)
                        Text(user.company?.name ?? "").font(.body)
                    }.padding()
                }
            }
            .navigationTitle("Users")
            .onAppear {
                userList.fetchElements()
            }
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
            .environmentObject(ElementList<JPUser>())
    }
}
