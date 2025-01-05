//
//  GetAlbumsService.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 04/01/25.
//

protocol GetAlbumsServiceProtocol {
    func getAlbums() async -> Result<[AlbumsResponse], Error>
}


class GetAlbumsService: GetAlbumsServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()){
        self.networkManager = networkManager
    }
    
    func getAlbums() async -> Result<[AlbumsResponse], Error> {
        do {
            return .success(
                try await networkManager
                    .fetch(
                        urlComponent: APIURLItemType.getAlbums(query: ""),
                        method: .get
                    )
            )
        } catch {
            return .failure(error)
        }
    }
}
