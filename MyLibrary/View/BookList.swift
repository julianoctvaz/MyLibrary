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
                let index = viewModel.books.firstIndex(where: { $0.id == book.id })!
                
                NavigationLink(destination: BookEdit(book: $viewModel.books[index])) {
                    BookRow(book: book)
                    //Note, é $viewModel e nao viewModel.$books pois books se refere a um @published, enquanto viewModel se refere a ligacao (binding) para o @observedObjected, nem tente fazer da segunda forma...
                }
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
