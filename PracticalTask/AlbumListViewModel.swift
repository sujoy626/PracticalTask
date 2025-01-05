//
//  AlbumListViewModel.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 04/01/25.
//

import Combine
import Foundation


@MainActor
final class AlbumListViewModel : BaseViewModel {
    
    
    @Published private(set) var albums: [AlbumDataModel] = [
        .init(apiID: 1, userID: 1, title: "Albums...", photos: [])
    ]
    
    private let dataService: AlbumDataServiceProtocol
    
    init(dataService: AlbumDataServiceProtocol = AlbumDataService()) {
        self.dataService = dataService
        super.init()
        
        loadAlbums()
    }
    
    
    private func loadAlbums() {
        self.updateViewState(.loading("Loading Albums..."))
        Task {
            let result = await dataService.fetchOrSave()
            
            switch result {
            case .success(let albums):
                if albums.isEmpty {
                    self.updateViewState(.empty("No Albums Found"))
                } else {
                    self.albums = albums
                    self.updateViewState(.loaded)
                }
            case .failure(let error):
                albums = []
                self.updateViewState(.error(error.localizedDescription))
                
            }
        }
    }
    
    
  
}
