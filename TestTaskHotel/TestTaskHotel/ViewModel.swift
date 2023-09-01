//
//  ViewModel.swift
//  TestTaskHotel
//
//  Created by Иван Вдовин on 30.08.2023.
//

import Foundation

class AppViewModel<T: Repository>: ObservableObject where T.T == Hotel {
    @Published var hotels: [Hotel] = []
    let repository: T
    
    init(repository: T) {
        self.repository = repository
    }
    
    func getHotels() {
        self.hotels = repository.readAll()
    }
}
