//
//  AlbumDataService.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 05/01/25.
//

import Foundation

protocol AlbumDataServiceProtocol {
    func fetchOrSave() async -> Result<[AlbumDataModel], Error>
}

final class AlbumDataService: AlbumDataServiceProtocol {

    private let getAlbumsService: GetAlbumsServiceProtocol
    private let getPhotosService: GetPhotosServiceProtocol
    private let realmManager: RealmManagerProtocol

    init(getAlbumsService: GetAlbumsServiceProtocol = GetAlbumsService(),
         getPhotosService: GetPhotosServiceProtocol = GetPhotosService(),
         realmManager: RealmManagerProtocol = RealmManager()) {
        self.getAlbumsService = getAlbumsService
        self.getPhotosService = getPhotosService
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
    
    func fetchPhotosFromAPI() async -> Result<[PhotoDataModel], Error> {
        let apiResult = await getPhotosService.getPhotos()
        
        switch apiResult {
        case .success(let photosResponse):
            let photos = photosResponse.map { response in
                PhotoObject(
                    apiID: response.id,
                    albumID: response.albumID,
                    title: response.title,
                    thumbnailURL: response.thumbnailURL,
                    url: response.url
                )
            }
            realmManager.save(photos, update: false)
            
            return .success(photos.map { photo in
                PhotoDataModel(
                    apiID: photo.apiID,
                    albumID: photo.albumID,
                    title: photo.title,
                    thumbnailURL: photo.thumbnailURL,
                    url: photo.url
                )
            })
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func fetchAlbumsFromRealm() -> [AlbumDataModel] {
        let realmAlbums = realmManager.fetch(AlbumObject.self, filter: nil)
        let realmPhotos = realmManager.fetch(PhotoObject.self, filter: nil).map { photo in
            PhotoDataModel(
                apiID: photo.apiID,
                albumID: photo.albumID,
                title: photo.title,
                thumbnailURL: photo.thumbnailURL,
                url: photo.url
            )
        }
        
        return realmAlbums.map { album in
            AlbumDataModel(
                apiID: album.apiID,
                userID: album.userID,
                title: album.title,
                photos: realmPhotos.filter { $0.albumID == album.apiID }
            )
        }
    }
    
    func fetchOrSave() async -> Result<[AlbumDataModel], Error> {
        let cachedAlbums = fetchAlbumsFromRealm()
        guard cachedAlbums.isEmpty else {
            return .success(cachedAlbums)
        }
        
        let albumsResult = await fetchAlbumsFromAPI()
        switch albumsResult {
        case .success:
            let photosResult = await fetchPhotosFromAPI()
            switch photosResult {
            case .success:
                return .success(fetchAlbumsFromRealm())
            case .failure(let error):
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
