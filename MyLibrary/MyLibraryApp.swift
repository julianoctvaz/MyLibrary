//
//  MyLibraryApp.swift
//  MyLibrary
//
//  Created by Juliano Vaz on 15/02/21.
//

import SwiftUI

@main
struct MyLibraryApp: App {
    
    let booksViewModel = BooksViewModel() //colocamos aqui pq é provável que você queira reutilizar (!=compartilhar? Dúvida) esse ViewModel em outro lugar em seu aplicativo. Se você está mantendo um ObservableObject contido em uma (UNICA) view, pode usar @StateObject em vez de @ObservedObject.
    
    var body: some Scene {
        WindowGroup {
            BookList(viewModel: booksViewModel) // ja é uma variavel da struct, ela é usada como parametro aqui na scene, se tirar reclama
        }
    }
}
