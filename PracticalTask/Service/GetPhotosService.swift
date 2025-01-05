//
//  GetPhotosService.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 04/01/25.
//


protocol GetPhotosServiceProtocol {
    func getPhotos() async -> Result<[PhotosResponse], Error>
}


class GetPhotosService: GetPhotosServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()){
        self.networkManager = networkManager
    }
    
    func getPhotos() async -> Result<[PhotosResponse], Error> {
        do {
            return .success(
                try await networkManager.fetch(urlComponent: APIURLItemType.getPhotos(query: ""), method: .get)
            )
        } catch {
            return .failure(error)
        }
    }
}
