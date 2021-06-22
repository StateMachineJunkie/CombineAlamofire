//
//  ToDoListView.swift
//  CombineAlamofireSwiftUIApp
//
//  Created by Michael A. Crawford on 6/14/21.
//

import CombineAlamofire
import SwiftUI

struct ToDoListView: View {
    @EnvironmentObject private var todoList: ElementList<JPToDo>

    var body: some View {
        NavigationView {
            List {
                ForEach(todoList.elements) { todo in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("#\(todo.id.rawValue)")
                                .font(.caption)
                            Spacer()
                            Text("#\(todo.userId.rawValue)")
                                .font(.caption)
                        }
                        Text(todo.title)
                            .font(.title3)
                            .padding(.top, 1)
                    }
                }
            }
            .navigationTitle("ToDo")
            .onAppear {
                todoList.fetchElements()
            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
