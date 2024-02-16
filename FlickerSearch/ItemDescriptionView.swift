//
//  ItemDescriptionView.swift
//  FlickerSearch
//
//  Created by shiva on 2/15/24.
//

import SwiftUI

struct ItemDescriptionView: View {
    @State var item: Item?
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 8) {
                AsyncImage(url: URL(string: item?.media.m ?? "")) { phase in
                    if let image = phase.image {
                        image // Displays the loaded image.
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Rectangle())
                    } else if phase.error != nil { // Indicates an error.
                        Color.red
                            .clipShape(Rectangle())
                    } else { // Acts as a placeholder.
                        ProgressView()
                            .clipShape(Rectangle())
                    }
                }
                .frame(height: 200)
                
                VStack {
                    HStack(alignment: .center) {
                        Text("Title :: ").customTitle()
                        if let title = item?.title {
                            Text(title).customBody()
                        }
                    }
                    HStack(alignment: .center) {
                        Text("Description :: ").customTitle()
                           
                        if let desc = item?.description {
                            HTMLTextRepresentable(html: desc)
                        }
                    }
                    
                    HStack(alignment: .center) {
                        Text("Author :: ").customTitle()
                        if let title = item?.author {
                            Text(title).customBody()
                        }
                    }
                    
                    HStack(alignment: .center) {
                        Text("Published Date :: ").customTitle()
                        if let published = item?.published,
                            let publishedDate = getFormattedDate(input: published) {
                            Text(publishedDate).customBody()
                        }
                    }
                }
            }
        }
        .padding([.leading, .trailing], 8)
    }
}

struct ItemDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDescriptionView()
    }
}

