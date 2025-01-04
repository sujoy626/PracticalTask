//
//  AlbumList.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 04/01/25.
//

import SwiftUI


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
    
    @State var items = [.red, .blue, .green].map { ListItem(color: $0)}
    
    @StateObject var viewModel = AlbumListViewModel()
    
    var body: some View {
        LoopingVerticalScrollView(height:190, spacing: 0, items: viewModel.albums) { album in
            VStack(alignment: .leading, spacing: 8) {
                Text(album.title ?? "-")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                LoopingHorizontalScrollView(width: 150, spacing: 10, items: items) { item in
                    RoundedRectangle(cornerRadius: 15)
                        .fill(item.color.gradient)
                }
                .contentMargins(.horizontal, 0, for:.scrollContent)
                .frame(height: 150)
            }
//            .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
        }
        .padding(.vertical, 8)
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
        //        }
        .safeAreaPadding()
        .padding(.bottom,12)
        .onAppear{
            viewModel.getAlbums()
        }
        
    }
}


#Preview{
    AlbumListView()
}
