//
//  BooksViewModel.swift
//  MyLibrary
//
//  Created by Juliano Vaz on 15/02/21.
//
//ViewModel também chamada de modelo de visão, faz a ponte da view com o model, tem que ser fracamente acoplado e fortemente coeso. Seria o controller, do MVC... apesar disso nao está muito claro ainda.
import Foundation

//You can only use ObservableObject with a class. Also, keep in mind that @Published will emit to subscribers before the value changes. This is only relevant if you’re subscribing manually, but it’s good to know!

class BooksViewModel: ObservableObject { //Quando você adota esse protocolo em sua própria classe, está essencialmente transformando as instâncias de classe em publishers (editores) que podem emitir valores para qualquer um que os assine. Este é um princípio básico da estrutura Combine. O ObservableObjectprotocolo tem uma implementação padrão para seu objectWillChange publisher(editor), que emite o valor alterado para qualquer uma das propriedades da classe . Estamos usando aquele wrapper de propriedade para a propriedade.@Published books. Agora você pode observar um objeto do tipo BooksViewModel para alterações no array de books. Sempre que os dados nesse array mudam, você obtém um ping. Um ping para onde? Bem, qualquer assinante (subscriber) receberá um ping. Adivinha quem vai se inscrever? A BookListView, é claro!
    let url:URL! = URL(string: "https://gist.githubusercontent.com/reinder42/6f5dffd8e9a6a78a56963ab3b1694238/raw/66a6cba5a878bb9a464188dbd1378ec4b0aa4714/books.json")
    //Você precisa desembrulhar os opcionais para usá-los com segurança
    //temValor!
    //Uma propriedade de saída do controlador de visualização, que é nilanterior à propriedade carregada do controlador de visualização. Até que seja carregado, você não pode usá-lo.
    //Em um aplicativo, existem muitos cenários em que eles são úteis. Os campos do formulário que não estão preenchidos são apenas um deles.
    @Published var books = [Book]()
   // agora, vamos falar sobre @Published. Já sabemos que ObservableObject usa propriedades que têm o wrapper de propriedade @Published, mas há mais. O wrapper de propriedade @Published essencialmente transforma a propriedade em um editor. Isso significa que você pode assinar (subscribes) a propriedade e responder às alterações que o editor (Published) emite. Isso é o que faremos com @ObservedObject, mais tarde.
}
