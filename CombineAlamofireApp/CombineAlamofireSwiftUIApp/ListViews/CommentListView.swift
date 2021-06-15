//
//  CommentListView.swift
//  CombineAlamofireSwiftUIApp
//
//  Created by Michael A. Crawford on 6/14/21.
//

import CombineAlamofire
import SwiftUI

struct CommentListView: View {
    @EnvironmentObject private var commentList: ElementList<JPComment>

    var body: some View {
        NavigationView {
            List {
                ForEach(commentList.elements) { comment in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("#\(comment.id.rawValue)")
                                .font(.caption)
                            Spacer()
                            Text(comment.email.rawValue)
                                .font(.caption)
                        }
                        Text(comment.name)
                            .font(.title3)
                            .padding([.top, .bottom], 3.0)
                        Text(comment.body)
                            .font(.body)
                    }
                    .padding()
                }
            }
            .navigationTitle("Comment")
            .onAppear {
                commentList.fetchElements()
            }
        }
    }
}

struct CommentListView_Previews: PreviewProvider {
    static var previews: some View {
        CommentListView()
            .environmentObject(ElementList<JPComment>())
    }
}
