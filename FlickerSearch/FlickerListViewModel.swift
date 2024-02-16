//
//  FlickerListViewModel.swift
//  FlickerSearch
//
//  Created by shiva on 2/15/24.
//


import Foundation

class FlickerListViewModel: ObservableObject {
    
    var flickerService = FlickerService()

    @Published var flickerData: FlickerData?

    func fetchFlickerData(searchText: String) {
        
        flickerService.fetchFlickerData(searchText: searchText) { result in
            switch result {
            case .success(let fetchedFlickerData):
                DispatchQueue.main.async {
                    self.flickerData = fetchedFlickerData
                }
                print("*** Flicker Search Result Servicedata:: \(String(describing: self.flickerData))")
                
            case .failure(let error):
                print("Fetching data failer with error :: \(error)")
            }
        }
    }
}
