//
//  AlbumDataService.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 05/01/25.
//

import Foundation

protocol AlbumDataServiceProtocol {
    func fetchAlbums() async -> Result<[AlbumDataModel], Error>
}

final class AlbumDataService: AlbumDataServiceProtocol {
    

    private let getAlbumsService: GetAlbumsServiceProtocol
    private let realmManager: RealmManagerProtocol
    
    init(getAlbumsService: GetAlbumsServiceProtocol = GetAlbumsService(),
         realmManager: RealmManagerProtocol = RealmManager()) {
        self.getAlbumsService = getAlbumsService
        self.realmManager = realmManager
    }
    
    func fetchAlbumsFromAPI() async -> Result<[AlbumDataModel], Error> {
        let apiResult = await getAlbumsService.getAlbums()
        
        switch apiResult {
        case .success(let albumsResponse):
            let albums = albumsResponse.map { response in
                AlbumObject(apiID: response.id, userID: response.userID, title: response.title)
            }
            realmManager.save(albums, update: false)
            return .success(fetchAlbumsFromRealm())
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    
    func fetchPhotosFromAPI() async -> Result<[AlbumDataModel], Error> {
        let apiResult = await getAlbumsService.getAlbums()
        
        switch apiResult {
        case .success(let albumsResponse):
            let albums = albumsResponse.map { response in
                AlbumObject(apiID: response.id, userID: response.userID, title: response.title)
            }
            realmManager.save(albums, update: false)
            return .success(fetchAlbumsFromRealm())
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    
    
    func fetchAlbumsFromRealm() -> [AlbumDataModel] {
        let realmAlbums = realmManager.fetch(AlbumObject.self, filter: nil)
        return realmAlbums.map { album in
            AlbumDataModel(apiID: album.apiID, userID: album.userID, title: album.title)
        }
    }
    
    
    
    
    func fetchAlbums() async -> Result<[AlbumDataModel], Error> {
        let cachedAlbums = fetchAlbumsFromRealm()
        guard cachedAlbums.isEmpty else {
            return .success(cachedAlbums)
        }
        return await fetchAlbumsFromAPI()
        
    }
    
    
}
