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
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        NavigationView {
            List {
                ForEach(photoList.elements) { photo in
                    HStack {
                        if #available(iOS 15.0, *) {
                            AsyncImage(url: photo.thumbnailUrl) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .frame(width: 64, height: 54, alignment: .center)
                                } else if phase.error != nil {
                                    Image(systemName: "exclamationmark.circle")
                                        .resizable()
                                        .frame(width: 64, height: 54, alignment: .center)
                                } else {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .frame(width: 64, height: 54, alignment: .center)
                                }
                            }
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 64, height: 54, alignment: .center)
                        }
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
            .navigationBarItems(trailing:
                Button {
                    showingImagePicker = true
                } label: {
                    Image(systemName: "plus.circle")
                }
            )
            .onAppear {
                photoList.fetchElements()
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView()
            .environmentObject(ElementList<JPPhoto>())
    }
}
