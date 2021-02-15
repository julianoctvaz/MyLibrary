//
//  BookList.swift
//  MyLibrary
//
//  Created by Juliano Vaz on 15/02/21.
//

import SwiftUI

struct BookList: View
{
    var body: some View {
        NavigationView {
            List(books) { book in
                BookRow(book: book)
            }
            .navigationBarTitle("Books")
        }
    }
}

struct BookList_Previews: PreviewProvider {
    static var previews: some View {
        BookList()
    }
}
