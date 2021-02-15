//
//  BooksViewModel.swift
//  MyLibrary
//
//  Created by Juliano Vaz on 15/02/21.
//
//ViewModel também chamada de modelo de visão, faz a ponte da view com o model, tem que ser fracamente acoplado e fortemente coeso. Seria o controller, do MVC... apesar disso nao está muito claro ainda.
import Foundation
import Combine

//Às vezes, a fonte de verdade dos seus dados não reside dentro de uma visualização SwiftUI. Nesse caso, use o ObservableObjectprotocolo para permitir que uma classe interaja com o SwiftUI. 

//You can only use ObservableObject with a class. Also, keep in mind that @Published will emit to subscribers before the value changes. This is only relevant if you’re subscribing manually, but it’s good to know!

class BooksViewModel: ObservableObject { //Quando você adota esse protocolo em sua própria classe, está essencialmente transformando as instâncias de classe em publishers (editores) que podem emitir valores para qualquer um que os assine. Este é um princípio básico da estrutura Combine. O ObservableObjectprotocolo tem uma implementação padrão para seu objectWillChange publisher(editor), que emite o valor alterado para qualquer uma das propriedades da classe . Estamos usando aquele wrapper de propriedade para a propriedade.@Published books. Agora você pode observar um objeto do tipo BooksViewModel para alterações no array de books. Sempre que os dados nesse array mudam, você obtém um ping. Um ping para onde? Bem, qualquer assinante (subscriber) receberá um ping. Adivinha quem vai se inscrever? A BookListView, é claro!
    let url:URL! = URL(string: "https://gist.githubusercontent.com/reinder42/6f5dffd8e9a6a78a56963ab3b1694238/raw/66a6cba5a878bb9a464188dbd1378ec4b0aa4714/books.json")
    //Você precisa desembrulhar os opcionais para usá-los com segurança
    //temValor!
    //Uma propriedade de saída do controlador de visualização, que é nilanterior à propriedade carregada do controlador de visualização. Até que seja carregado, você não pode usá-lo.
    //Em um aplicativo, existem muitos cenários em que eles são úteis. Os campos do formulário que não estão preenchidos são apenas um deles.
    @Published var books = [Book]() //The @Published property wrapper is what triggers any updates in observers of an ObservableObject.
   // agora, vamos falar sobre @Published. Já sabemos que ObservableObject usa propriedades que têm o wrapper de propriedade @Published, mas há mais. O wrapper de propriedade @Published essencialmente transforma a propriedade em um editor. Isso significa que você pode assinar (subscribes) a propriedade e responder às alterações que o editor (Published) emite. Isso é o que faremos com @ObservedObject, mais tarde.


/*
 A próxima etapa que daremos é buscar os dados do livro na BooksViewModel classe.
 
 Conforme discutimos, o modelo de exibição é (vagamente) responsável por obter dados de uma fonte de dados (externa). Este não é o propósito do modelo de visualização no sentido mais estrito. Como não temos um controlador de banco de dados ou camada de persistência separada, é o suficiente por enquanto.
 */

    init() { //dai podemos tirar o onAppear de dentro da view... Alem do mais cuidado com o uso de init dentro de views é sempre uma boa observacao. A estrutura de uma classe deve dizer respeito a ela, e nao a coisas externas que possam gerar depedencia ou alto acomplamento de diferentes arquivos de codigo.
        fetchBooks()
    }
    
    
    func fetchBooks(){
    URLSession.shared.dataTaskPublisher(for: url)
        .map { $0.data } //taking the output of the publisher
        .decode(type: [Book].self, decoder: JSONDecoder())//decoding the data value, with the JSONDecoder decoder, and create an ARRAY of Book objects from it.
        .replaceError(with: []) //itsessentially replace any errors with an empty array; the best-case approach, por enquanto, tudo bem, mas em seus próprios aplicativos você vai querer responder aos erros de outra maneira. Por exemplo, você pode escolher rejeitar códigos de status HTTP diferentes de 200.
        .eraseToAnyPublisher() // topico mais complexo, so assuma que isso mudará o tipo de editor de algo complexo para o mais simples AnyPublisher<[Book], Never>
        .receive(on: DispatchQueue.main) //receber suas atualizações no thread principal, para "poder atualizar as visualizacoes do fio de execucao principal""
        .assign(to: &$books) //estamos dizendo ao editor - você sabe, o código acima dele - para republicar os valores que ele emite e atribuí-los à books propriedade. Pense nisso como um macaco que repete tudo o que outro macaco diz. E esses &$ significa que o mcador do To: é um inout, e precisa tb ser passado por referencia, e nao por copia de valores.
        
       // Mais informacoes https://learnappmaking.com/urlsession-swift-networking-how-to/
        //A partir do link acima a um uso generico de urlsession, sem que seja com publisher.
        //NAo usamos um shared.dataTask qualquer, em vez de um manipulador de conclusão (completion handler) para a resposta, este código cria um editor, um  PUBLISHER

    }
/*
De uma visão panorâmica, este é o código que usa a estrutura Combine para obter um arquivo JSON baseado na web, transformá-lo em uma matriz de Bookobjetos e atribuí-lo à propriedade books de BooksViewModel. É uma “cadeia” de operadores Combine, que usa o padrão builder que você já conhece do SwiftUI.
*/
    
//    Se os dados para booksin BooksViewModelnão vêm de um recurso JSON baseado na web, de onde eles vêm? Você pode usar praticamente qualquer editor lá! Core Data, Realm, uma API personalizada, um arquivo JSON no disco - qualquer coisa!
    
//    Depois de editar os dados BookEdit, para onde eles vão? Desde que esteja trabalhando com uma API online, você pode enviar os dados alterados de volta para persistência fica aqui um pedacinho do code para isso como desafio:
    
    var cancellables = Set<AnyCancellable>()
    // Note: import Combine, too!
    
    func updateBooks()
    {
        $books.sink { books in
            
            for book in books {
                print("Sending book '\(book.title)' to custom web API...")
            }
            
        }.store(in: &cancellables)
    }
}
