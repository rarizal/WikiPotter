//
//  DetailsView.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 22/11/25.
//

import SwiftUI
import Kingfisher

struct DetailsView: View {
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (spacing: 20) {
                KFImage(URL(string: "https://www.wizardingworld.com/images/products/books/UK/rectangle-2.jpg"))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350, height: 600)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                HStack (spacing: 10) {
                    Text("Book")
                        .font(.footnote)
                                .foregroundColor(.secondary)
                                .padding(8)
                                .background(.gray.opacity(0.1), in: Capsule())
                    
                    Text("251 pages")
                        .font(.footnote)
                                .foregroundColor(.secondary)
                                .padding(8)
                                .background(.gray.opacity(0.1), in: Capsule())
                    
                    Text("1998-07-02")
                        .font(.footnote)
                                .foregroundColor(.secondary)
                                .padding(8)
                                .background(.gray.opacity(0.1), in: Capsule())
                }
                
                Text("Harry Potter and the Chamber of Secrets")
                    .font(Font.largeTitle.bold())
                
                Text("A young boy discovers that he is a wizard and attends Hogwarts School of Witchcraft and Wizardry.")
                
            }
        }.padding()
        
        
    }
}

#Preview {
    DetailsView()
}
