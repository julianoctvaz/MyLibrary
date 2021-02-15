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
                /*The firstIndex(where:) function returns the (first) index of the array item for which the given predicate is true. That predicate is the closure $0.id == book.id. In other words, find the index in the array for which the array’s item’s id property is equal to book.id, which is the current item in the List.
                 If you search online, you’ll find a few alternatives to solve this problem. Most notably, using Array(books.enumerated()) and ForEach, like in this tutorial, to get the index of the current book in the array. I’ve chosen to work with firstIndex(where:) to get 1-on-1 parity between the book.id and books, but it has the disadvantage of O(n) time complexity inside the List. If you end up using the array’s indices, keep in mind that the external data source may not have a fixed sort order. The ideal scenario would be a ViewModel with a custom collection type that provides Identifiable and random access out of the box.
                 */
                
                NavigationLink(destination: BookEdit(book: $viewModel.books[index])) {
                    BookRow(book: book)
                    //Note, é $viewModel e nao viewModel.$books pois books se refere a um @published, enquanto viewModel se refere a ligacao (binding) para o @observedObjected, nem tente fazer da segunda forma...
                }
            }
            .navigationBarTitle("Books")
//            .onAppear {// sem essa funcao ele nao faz a busca externa, nao mostra lista nenhuma
//                viewModel.fetchBooks()
//            }//Mais tarde, você pode querer começar fetchBooks()em um lugar diferente. Se você mantiver onAppear, verá que os dados do livro são buscados sempre que a BookListvisualização aparecer. Você também pode invocar fetchBooks()no inicializador de BooksViewModel, por exemplo, ou com base na ação do usuário.
        }
    }
}

//struct BookList_Previews: PreviewProvider {
//    static var previews: some View {
//        BookList()
//    }
//}
