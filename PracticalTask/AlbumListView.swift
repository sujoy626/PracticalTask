//
//  AlbumList.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 04/01/25.
//

import SwiftUI
import URLImage


struct ListItem: Identifiable {
    let id = UUID()
    let color: Color
}

struct Album: Identifiable {
    let id = UUID()
    let title: String
    let items: [ListItem]
}


struct AlbumListView: View {
    //    @State private var albums: [Album] = ["Title 1", "Title 2", "Title 3", "Title 4","Title 5","Title 6"].map {
    //        Album(title: $0, items: [.red, .blue, .green].map { ListItem(color: $0) })
    //    }
    
//    @State var items = [.red, .blue, .green].map { ListItem(color: $0)}
    
    @StateObject var viewModel = AlbumListViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color(.yellow)
                    .ignoresSafeArea()
                switch viewModel.viewState {
                case .loading(let message):
                    Text(message)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                case .initial:
                    Text("initial...")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                case .loaded:
                    VStack{
                        LoopingVerticalScrollView(height:190, spacing: 0, items: viewModel.albums) { album in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(album.title)
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                LoopingHorizontalScrollView(width: 150, spacing: 10, items: album.photos) { item in
                                    ZStack{
//                                        RoundedRectangle(cornerRadius: 15)
//                                            .fill(item.color.gradient)
//                                        let _ = print("item.thumbnailURL: \(item.thumbnailURL)")
                                        if let imageURl = URL(string: item.thumbnailURL) {
                                            URLImage(imageURl) {
                                                // This view is displayed before download starts
                                                EmptyView()
                                            } inProgress: { progress in
                                                // Display progress
                                                Text("Loading...")
                                            } failure: { error, retry in
                                                // Display error and retry button
                                                VStack {
                                                    Text(error.localizedDescription)
                                                    Button("Retry", action: retry)
                                                }
                                            } content: { image in
                                                // Downloaded image
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                            }
                                        } else {
                                            Image(systemName: "photo")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                        }
                                        
                                    }
                                    .cornerRadius(16)
                                }
                                .contentMargins(.horizontal, 0, for:.scrollContent)
                                .frame(height: 150)
                            }
                            //            .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                        }
                    }
                    .safeAreaPadding()
                case .empty(let message):
                    Text(message)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                case .error(let message):
                    Text(message)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                case .loadMore(let message):
                    Text(message)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
            }
        }
        .navigationTitle("Albums")
        
    }
    
}



#Preview{
    AlbumListView()
}
