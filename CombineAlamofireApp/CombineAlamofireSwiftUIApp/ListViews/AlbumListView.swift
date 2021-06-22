//
//  AlbumListView.swift
//  CombineAlamofireSwiftUIApp
//
//  Created by Michael A. Crawford on 6/14/21.
//

import CombineAlamofire
import SwiftUI

struct AlbumListView: View {
    @EnvironmentObject private var albumList: ElementList<JPAlbum>

    var body: some View {
        NavigationView {
            List {
                ForEach(albumList.elements) { album in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("#\(album.id.rawValue)")
                                .font(.caption)
                            Spacer()
                            Text("#\(album.userId.rawValue)")
                                .font(.caption)
                        }
                        Text(album.title)
                            .font(.title3)
                            .padding([.top], 3.0)
                    }
                }
            }
            .navigationTitle("Albums")
            .onAppear {
                albumList.fetchElements()
            }
        }
    }
}

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView()
            .environmentObject(ElementList<JPAlbum>())
    }
}
