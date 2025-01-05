//
//  AlbumDataService.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 05/01/25.
//

import Foundation

protocol AlbumDataServiceProtocol {
//    func fetchAlbums() async -> Result<[AlbumDataModel], Error>
    func fetchAlbums() async -> Result<[AlbumDataModel], Error>
    func insertDummyDataIfNeeded()
}

final class AlbumDataService: AlbumDataServiceProtocol {
    

    private let apiService: GetAlbumsServiceProtocol
    private let realmManager: RealmManagerProtocol
    
    init(apiService: GetAlbumsServiceProtocol = GetAlbumsService(),
         realmManager: RealmManagerProtocol = RealmManager()) {
        self.apiService = apiService
        self.realmManager = realmManager
    }
    
    func fetchAlbumsFromAPI() async -> Result<[AlbumDataModel], Error> {
        let apiResult = await apiService.getAlbums()
        
        switch apiResult {
        case .success(let albumsResponse):
            let albums = albumsResponse.map { response in
                AlbumsObject(apiID: response.id, userID: response.userID, title: response.title)
            }
            realmManager.save(albums, update: false)
            return .success(fetchAlbumsFromRealm())
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func fetchAlbumsFromRealm() -> [AlbumDataModel] {
        let realmAlbums = realmManager.fetch(AlbumsObject.self, filter: nil)
        return realmAlbums.map { album in
            AlbumDataModel(apiID: album.apiID, userID: album.userID, title: album.title)
        }
    }
    
    func fetchAlbums() async -> Result<[AlbumDataModel], Error> {
        let cachedAlbums = fetchAlbumsFromRealm()
        guard !cachedAlbums.isEmpty else {
            return .success(cachedAlbums)
        }
        return await fetchAlbumsFromAPI()
        
    }
    
    func insertDummyDataIfNeeded() {
        realmManager.insertDummyDataIfNeeded()
    }
}
