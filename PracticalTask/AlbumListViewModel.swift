//
//  AlbumListViewModel.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 04/01/25.
//

import Combine
import Foundation
import RealmSwift


@MainActor
final class AlbumListViewModel : BaseViewModel {
    
    
    @Published private(set) var albums: [AlbumDataModel] = []
    
    
    
    private let service : GetAlbumsServiceProtocol
    
    init(service: GetAlbumsServiceProtocol = GetAlbumsService()){
        self.service = service
        super.init()
        
        insertDummyData()
        fetchAlbumsFromRealm()
    }
    
    private func insertDummyData(){
        albums = [
            .init(apiID: 1, userID: 1, title: "Test Album 1 and bla test"),
            .init(apiID: 2, userID: 2, title: "Test Album 2 bla bla bla"),
            .init(apiID: 3, userID: 3, title: "XXX Album 3 bla bla bla"),
            
        ]
    }
    
    
    
    func getAlbumsFromRemoteServer() {
        self.updateViewState(.loading("Loading Albums..."))
        Task {
            let res = await service.getAlbums()
            self.updateViewState(.loaded)
            
            switch res {
            case .success(let albumsResponse):
                saveAlbumsToRealm(albumsResponse)
                fetchAlbumsFromRealm()
            case .failure(let error):
                self.updateViewState(.error(error.localizedDescription))
            }
        }
    }
    
    
    
    
    
    private let realm = try! Realm()
    private func saveAlbumsToRealm(_ albums: [AlbumsResponse]) {
        do {
            try realm.write {
                for album in albums {
                    if realm.objects(AlbumsObject.self).filter("apiID == %@", album.id).isEmpty {
                        let newAlbum = AlbumsObject()
                        newAlbum.apiID = album.id
                        newAlbum.userID = album.userID
                        newAlbum.title = album.title
                        realm.add(newAlbum)
                    }
                }
            }
        } catch {
            print("Failed to save albums to Realm: \(error.localizedDescription)")
        }
    }
    
    private func fetchAlbumsFromRealm() {
        let realmAlbums = realm.objects(AlbumsObject.self)
        guard !realmAlbums.isEmpty else {
            insertDummyData()
            return
        }
        
        self.albums = realmAlbums.map { album in
            AlbumDataModel(apiID: album.apiID, userID: album.userID, title: album.title)
        }
    }
    
    
    
}
