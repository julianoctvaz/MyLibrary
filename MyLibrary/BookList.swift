//
//  BookList.swift
//  MyLibrary
//
//  Created by Juliano Vaz on 15/02/21.
//

import SwiftUI

struct BookList: View{
    
    @ObservedObject var viewModel: BooksViewModel //ou seja, essa view depende do estado dessa variavel
    
    var body: some View {
        NavigationView {
            List(viewModel.books) { book in
                BookRow(book: book)
            }
            .navigationBarTitle("Books")
            .onAppear {// sem essa funcao ele nao faz a busca externa, nao mostra lista nenhuma
                viewModel.fetchBooks()
            }
        }
    }
}

//struct BookList_Previews: PreviewProvider {
//    static var previews: some View {
//        BookList()
//    }
//}
