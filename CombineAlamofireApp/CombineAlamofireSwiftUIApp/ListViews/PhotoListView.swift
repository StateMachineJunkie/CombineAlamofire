//
//  PhotoListView.swift
//  CombineAlamofireSwiftUIApp
//
//  Created by Michael A. Crawford on 6/14/21.
//

import CombineAlamofire
import SwiftUI

struct PhotoListView: View {
    @EnvironmentObject private var photoList: ElementList<JPPhoto>

    var body: some View {
        NavigationView {
            List {
                ForEach(photoList.elements) { photo in
                    HStack {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 64, height: 54, alignment: .center)
                        VStack(alignment: .leading) {
                            HStack {
                                Text("#\(photo.id.rawValue)")
                                    .font(.caption)
                                Spacer()
                                Text("#\(photo.albumId.rawValue)")
                                    .font(.caption)
                            }
                            Text(photo.title)
                                .font(.title3)
                                .padding(.top, 3)
                        }
                    }
                }
            }
            .navigationTitle("Photos")
            .onAppear {
                photoList.fetchElements()
            }
        }
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView()
            .environmentObject(ElementList<JPPhoto>())
    }
}
