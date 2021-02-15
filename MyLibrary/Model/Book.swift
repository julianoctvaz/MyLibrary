//
//  Book.swift
//  MyLibrary
//
//  Created by Juliano Vaz on 15/02/21.
//

import Foundation

struct Book: Identifiable, Codable {
    var id: Int //por ter o protocolo identifiable, deve ter um attr unico
    var title: String
    var author: String
}//A estrutura também está em conformidade com Codable , que é o protocolo que você usa para codificar e decodificar para JSON.

