//
//  Data.swift
//  TestTaskHotel
//
//  Created by Иван Вдовин on 30.08.2023.
//

import Foundation
import MapKit

protocol Repository {
    associatedtype T
    func create(_: T)
    func read() -> T
    func readAll() -> [T]
    func update(_: T)
    func delete(_: T)
}

class MockData: Repository {
    typealias T = Hotel
    func create(_: Hotel) { }
    func read() -> Hotel { return Hotel() }
    func update(_: Hotel) { }
    func delete(_: Hotel) { }
    
    func readAll() -> [Hotel] {
        return [Hotel(
            id: UUID(),
            photos: ["1", "2"],
            name: "Steigenberger Makadi",
            location: CLLocationCoordinate2D(latitude: 26.990560, longitude: 33.898204),
            price: 134673,
            info: "Отель VIP-класса с собственными гольф полями. Высокий уровнь сервиса. Рекомендуем для респектабельного отдыха. Отель принимает гостей от 18 лет!",
            preferences: [
                "3-я линия",
                "Платный Wi-Fi в фойе"
            ],
            rooms: [
                Room(id: UUID(),
                     name: "Стандартный с видом на бассейн или сад",
                     price: 18660,
                     preferences: [
                        "Все включено",
                        "Кондиционер"
                     ],
                     info: ""
                    )
            ]
        )]
    }
}
