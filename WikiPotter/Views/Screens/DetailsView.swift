//
//  DetailsView.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 22/11/25.
//

import SwiftUI
import Kingfisher

struct DetailsView<T: DetailProtocol>: View {
    var item: T
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (spacing: 20) {
                
                Group {
                    if let url = URL(string: item.image), url.scheme != nil {
                        KFImage(url)
                            .resizable()
                    } else {
                        Image(item.image)
                            .resizable()
                    }
                }
                    .scaledToFill()
                    .frame(width: 350, height: 600)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text(item.name)
                    .font(Font.largeTitle.bold())
                
                Text(item.description)
                    .padding(.horizontal)
                
            }
        }.padding()
        
        
    }
}

//#Preview {
//    DetailsView()
//}
