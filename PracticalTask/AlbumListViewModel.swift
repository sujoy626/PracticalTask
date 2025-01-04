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
    @Published private(set) var albums: [AlbumsResponse] = [
        .init(apiID: 1, userID: 1, title: "Test Album 1 and bla test"),
        .init(apiID: 2, userID: 2, title: "Test Album 2 bla bla bla"),
        .init(apiID: 3, userID: 3, title: "XXX Album 3 bla bla bla"),
        
    ]
    

    private let service : GetAlbumsServiceProtocol
    
    init(service: GetAlbumsServiceProtocol = GetAlbumsService()){
        self.service = service
        super.init()

    }
    
    
    func getAlbums(){
        self.updateViewState(.loading("Loading Albums..."))
        Task{
            let res = await service.getAlbums()
            self.updateViewState(.loaded)
            switch res {
            case .success(let albums):
                self.albums = albums
            case .failure(let error):
                self.updateViewState(.error(error.localizedDescription))
            }
        }
    }
    
    
}
