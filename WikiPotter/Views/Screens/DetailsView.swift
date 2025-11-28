//
//  DetailsView.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 22/11/25.
//

import SwiftUI
import Kingfisher

struct DetailsView: View {
    var book: BookDataWrapper
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (spacing: 20) {
                KFImage(URL(string: book.attributes.cover))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350, height: 600)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                HStack (spacing: 15) {
                    Text(book.type.capitalized)
                        .font(.footnote)
                                .foregroundColor(.secondary)
                                .padding(8)
                                .background(.gray.opacity(0.1), in: Capsule())
                    
                    Text("\(book.attributes.pages) pages")
                        .font(.footnote)
                                .foregroundColor(.secondary)
                                .padding(8)
                                .background(.gray.opacity(0.1), in: Capsule())
                    
                    Text(book.attributes.release_date)
                        .font(.footnote)
                                .foregroundColor(.secondary)
                                .padding(8)
                                .background(.gray.opacity(0.1), in: Capsule())
                }
                
                Text(book.attributes.title)
                    .font(Font.largeTitle.bold())
                
                Text(book.attributes.summary)
                    .padding(.horizontal)
                
            }
        }.padding()
        
        
    }
}

//#Preview {
//    DetailsView()
//}
