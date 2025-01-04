//
//  BaseViewModel.swift
//  PracticalTask
//
//  Created by Sujoy Adhikary on 04/01/25.
//

import Combine
import Foundation


enum ViewState{
    case initial
    case loading(String)
    case loaded
    case empty(String)
    case error(String)
    case loadMore(String)
}

protocol BaseViewModelProtocol: ObservableObject {}

class BaseViewModel : BaseViewModelProtocol{
    
    @Published private(set) var viewState : ViewState = .initial
    /*private*/ var cancellableBag = Set<AnyCancellable>()
    
    
    
    let identifier: UUID = UUID()
    
    func updateViewState(_ state: ViewState){
        DispatchQueue.main.async{ [weak self] in
            self?.viewState = state
        }
    }
}
