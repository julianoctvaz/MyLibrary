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
            }//Mais tarde, você pode querer começar fetchBooks()em um lugar diferente. Se você mantiver onAppear, verá que os dados do livro são buscados sempre que a BookListvisualização aparecer. Você também pode invocar fetchBooks()no inicializador de BooksViewModel, por exemplo, ou com base na ação do usuário.
        }
    }
}

//struct BookList_Previews: PreviewProvider {
//    static var previews: some View {
//        BookList()
//    }
//}
