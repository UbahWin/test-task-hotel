//
//  Models.swift
//  TestTaskHotel
//
//  Created by Иван Вдовин on 30.08.2023.
//

import Foundation
import MapKit

struct Hotel: Identifiable {
    var id: UUID
    var photos: [String]
    var name: String
    var location: CLLocationCoordinate2D
    var price: Int
    var info: String
    var preferences: [String]
    var rooms: [Room]
    
    init(id: UUID = UUID(), photos: [String] = [], name: String = "", location: CLLocationCoordinate2D = CLLocationCoordinate2D(), price: Int = 0, info: String = "", preferences: [String] = [], rooms: [Room] = []) {
        self.id = id
        self.photos = photos
        self.name = name
        self.location = location
        self.price = price
        self.info = info
        self.preferences = preferences
        self.rooms = rooms
    }
}

struct Room: Identifiable {
    var id: UUID
    var name: String
    var price: Int
    var preferences: [String]
    var info: String
}
