//
//  BookRow.swift
//  MyLibrary
//
//  Created by Juliano Vaz on 15/02/21.
//

import SwiftUI

struct BookRow: View{
    
    var book:Book
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text(book.title)
                .font(.headline)
                .padding([.leading, .trailing], 5)
            Text(book.author)
                .font(.subheadline)
                .padding([.leading, .trailing], 5)
        }
        .padding([.top, .bottom], 5)
    }
}

//struct BookRow_Previews: PreviewProvider {
//    static var previews: some View {
//        BookRow()
//    }
//}
