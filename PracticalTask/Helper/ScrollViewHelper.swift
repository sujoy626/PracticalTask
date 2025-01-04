//
//  ScrollViewHelper.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 04/01/25.
//

import SwiftUI

struct LoopingHorizontalScrollView<Content: View, Item: RandomAccessCollection>: View where Item.Element: Identifiable {
    var width: CGFloat
    var spacing: CGFloat = 0
    var items: Item
    @ViewBuilder var content: (Item.Element) -> Content
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let repeatingCount = width > 0 ? Int((size.width / width).rounded()) + 1 : 1// Extra items for seamless looping
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: spacing) {
                    // Original items
                    ForEach(items) { item in
                        content(item)
                            .frame(width: width)
                    }
                    
                    // Repeating items
                    ForEach(0..<repeatingCount, id: \.self) { index in
                        let item = Array(items)[index % items.count]
                        content(item)
                            .frame(width: width)
                    }
                }
                .background(
                    ScrollHorizontalViewHelper(
                        width: width,
                        spacing: spacing,
                        itemsCount: items.count,
                        repeatingCount: repeatingCount
                    )
                )
            }
        }
    }
}

fileprivate struct ScrollHorizontalViewHelper: UIViewRepresentable {
    var width: CGFloat
    var spacing: CGFloat
    var itemsCount: Int
    var repeatingCount: Int
    
    func makeUIView(context: Context) -> UIView {
        return .init()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.06) {
            if let scrollView = uiView.superview?.superview?.superview as? UIScrollView {
                if !context.coordinator.isAdded {
                    scrollView.delegate = context.coordinator
                    context.coordinator.isAdded = true
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(
            width: width,
            spacing: spacing,
            itemsCount: itemsCount,
            repeatingCount: repeatingCount
        )
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var width: CGFloat
        var spacing: CGFloat
        var itemsCount: Int
        var repeatingCount: Int
        
        init(width: CGFloat, spacing: CGFloat, itemsCount: Int, repeatingCount: Int) {
            self.width = width
            self.spacing = spacing
            self.itemsCount = itemsCount
            self.repeatingCount = repeatingCount
        }
        
        var isAdded = false
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let minX = scrollView.contentOffset.x
            let mainContentSize = CGFloat(itemsCount) * width
            let spacingSize = CGFloat(itemsCount) * spacing
            
            
            if minX > (mainContentSize + spacingSize) {
                scrollView.contentOffset.x -= (mainContentSize + spacingSize)
            }
            
            if minX < 0 {
                scrollView.contentOffset.x += (mainContentSize + spacingSize)
            }
        }
    }
}

struct LoopingVerticalScrollView<Content: View, Item: RandomAccessCollection>: View where Item.Element: Identifiable {
    var height: CGFloat
    var spacing: CGFloat = 0
    var items: Item
    @ViewBuilder var content: (Item.Element) -> Content
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let repeatingCount = height > 0 ? Int((size.height / height).rounded()) + 1 : 1
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: spacing) {
                    // Original items
                    ForEach(items) { item in
                        content(item)
                            .frame(height: height)
                    }
                    
                    // Repeating items
                    ForEach(0..<repeatingCount, id: \.self) { index in
                        let item = Array(items)[index % items.count]
                        content(item)
                            .frame(height: height)
                    }
                }
                .background(
                    ScrollVerticalViewHelper(
                        height: height,
                        spacing: spacing,
                        itemsCount: items.count,
                        repeatingCount: repeatingCount
                    )
                )
            }
        }
    }
}

fileprivate struct ScrollVerticalViewHelper: UIViewRepresentable {
    var height: CGFloat
    var spacing: CGFloat
    var itemsCount: Int
    var repeatingCount: Int
    
    func makeUIView(context: Context) -> UIView {
        return .init()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.06) {
            if let scrollView = uiView.superview?.superview?.superview as? UIScrollView {
                if !context.coordinator.isAdded {
                    scrollView.delegate = context.coordinator
                    context.coordinator.isAdded = true
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(
            height: height,
            spacing: spacing,
            itemsCount: itemsCount,
            repeatingCount: repeatingCount
        )
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var height: CGFloat
        var spacing: CGFloat
        var itemsCount: Int
        var repeatingCount: Int
        
        init(height: CGFloat, spacing: CGFloat, itemsCount: Int, repeatingCount: Int) {
            self.height = height
            self.spacing = spacing
            self.itemsCount = itemsCount
            self.repeatingCount = repeatingCount
        }
        
        var isAdded = false
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let minY = scrollView.contentOffset.y
            let mainContentSize = CGFloat(itemsCount) * height
            let spacingSize = CGFloat(itemsCount) * spacing
            
            if minY > (mainContentSize + spacingSize) {
                scrollView.contentOffset.y -= (mainContentSize + spacingSize)
            }
            
            if minY < 0 {
                scrollView.contentOffset.y += (mainContentSize + spacingSize)
            }
        }
    }
}

