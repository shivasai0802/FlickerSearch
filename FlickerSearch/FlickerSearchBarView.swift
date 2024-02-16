//
//  FlickerSearchBarView.swift
//  FlickerSearch
//
//  Created by shiva on 2/15/24.
//

import SwiftUI

struct FlickerSearchBarView: View {
    
    @ObservedObject private var viewModel = FlickerListViewModel()
    @State var searchText: String
    
    let columns = [ GridItem(.adaptive(minimum: 80)) ]
    
    var body: some View {
        VStack {
            if let flickerDataList = viewModel.flickerData?.items {
                NavigationView {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(flickerDataList, id:\.self) { flickerItem in
                                NavigationLink(destination: ItemDescriptionView(item: flickerItem)) {
                                    AsyncImage(url: URL(string: flickerItem.media.m)) { phase in
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
                                    .frame(width: 50, height: 50, alignment: .leading)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .navigationTitle("Flicker Data")
                    .searchable(text: $searchText, placement: .automatic)
                    .onChange(of: searchText) { value in
                        if !searchText.isEmpty && searchText.count >= 3 {
                            viewModel.fetchFlickerData(searchText: searchText)
                        }
                    }
                }
                
            }
        }
        .onAppear() {
            viewModel.fetchFlickerData(searchText: "")
        }
    }
}

struct FlickerSearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        FlickerSearchBarView(searchText: "porcupine")
    }
}
