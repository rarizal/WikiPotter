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
                KFImage(URL(string: item.image))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350, height: 600)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            
//                HStack (spacing: 15) {
//                    Text(item.type.capitalized)
//                        .font(.footnote)
//                                .foregroundColor(.secondary)
//                                .padding(8)
//                                .background(.gray.opacity(0.1), in: Capsule())
//                    
//                    Text("\(item.attributes.pages) pages")
//                        .font(.footnote)
//                                .foregroundColor(.secondary)
//                                .padding(8)
//                                .background(.gray.opacity(0.1), in: Capsule())
//                    
//                    Text(item.attributes.release_date)
//                        .font(.footnote)
//                                .foregroundColor(.secondary)
//                                .padding(8)
//                                .background(.gray.opacity(0.1), in: Capsule())
//                }
                
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
