//
//  CombineAlamofireSwiftUIAppApp.swift
//  CombineAlamofireSwiftUIApp
//
//  Created by Michael A. Crawford on 6/14/21.
//

import CombineAlamofire
import SwiftUI

@main
struct CombineAlamofireSwiftUIAppApp: App {
    @StateObject var userList = ElementList<JPUser>()
    @StateObject var commentList = ElementList<JPComment>()
    @StateObject var todoList = ElementList<JPToDo>()
    @StateObject var albumList = ElementList<JPAlbum>()
    @StateObject var photoList = ElementList<JPPhoto>()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userList)
                .environmentObject(commentList)
                .environmentObject(todoList)
                .environmentObject(albumList)
                .environmentObject(photoList)
        }
    }
}
