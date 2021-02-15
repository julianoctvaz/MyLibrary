//
//  BookEdit.swift
//  MyLibrary
//
//  Created by Juliano Vaz on 15/02/21.
//

import SwiftUI

struct BookEdit: View
{
    @Binding var book: Book
    /* O wrapper de propriedade @State também expõe uma vinculação (binding), por meio de seu valor projetado. Você acessa da mesma forma, com $. Por que estamos usando @Binding aqui, e não @State? Isso porque @State manterá e gerenciará seu próprio estado (ou seja, dados) (como uma variável local, uma propriedade da view instanciada/mostrada), enquanto @Binding é apenas uma PASSAGEM para dados armazenados em outro lugar.
     Isso se vincula ao princípio tão importante da fonte única da verdade. Em essência, isso significa que estamos apenas armazenando dados em um lugar e não fazemos cópias. Se uma visualização SwiftUI deseja saber quais dados mudam - para que possa atualizar a IU - ela deve saber inequivocamente de onde vêm os dados.
     Para nosso aplicativo MyLibrary, essa única fonte de verdade é a matriz books no objeto BooksViewModel em BookList. Faça qualquer tipo de cópias, com @State ou não, e você bagunça a ordem das coisas no pequeno universo do SwiftUI... :s
     */
    
    var body: some View {
        Form {
            Section(header: Text("About This Book")) {
                //This is the actual binding of some data with some UI component $variable.attr.
                //Assim voce acessa essa ligação, chamada de valor projetado (projected value.
                TextField("Title", text: $book.title)
                TextField("Author", text: $book.author)
                //Essa ligação pode ser passada para uma visão como TextField. Ao fazer isso, você está criando uma conexão bidirecional (orientada a estado)(reativa)(2-way connection) entre os dados e o TextField. O que alterar muda no corpo do armazenamento quando nas visualizacoes.
            }
        }
    }
}

struct BookEdit_Previews: PreviewProvider {
    static var previews: some View {
        BookEdit(book: .constant(Book(id: 1, title: "1984", author: "George Orwell")))
        //modo de colocar um visualizacao falsa quando tiver recebendo dados
    }
}
