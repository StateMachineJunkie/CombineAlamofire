//
//  ContentView.swift
//  CombineAlamofireSwiftUIApp
//
//  Created by Michael A. Crawford on 6/14/21.
//

import CombineAlamofire
import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
            UserListView()
                .tabItem {
                    Label("Users", systemImage: "person.fill")
                }
            CommentListView()
                .tabItem {
                    Label("Comments", systemImage: "text.bubble.fill")
                }
            ToDoListView()
                .tabItem {
                    Label("ToDo", systemImage: "checkmark.square.fill")
                }
            AlbumListView()
                .tabItem {
                    Label("Albums", systemImage: "photo.on.rectangle.fill")
                }
            PhotoListView()
                .tabItem {
                    Label("Photos", systemImage: "photo.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ElementList<JPUser>())
    }
}
