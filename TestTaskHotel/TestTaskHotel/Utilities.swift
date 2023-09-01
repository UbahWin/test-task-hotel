//
//  Utilities.swift
//  TestTaskHotel
//
//  Created by Иван Вдовин on 31.08.2023.
//

import Foundation
import MapKit
import SwiftUI

class Utilities: ObservableObject {
    func getAddressFromCoordinates(latitude: Double, longitude: Double, completion: @escaping (String?) -> Void) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Ошибка геокодирования: \(error.localizedDescription)")
                completion(nil)
            } else if let placemark = placemarks?.first {
                var addressComponents = [String]()
                
                if let name = placemark.name {
                    addressComponents.append(name)
                }
                
                if let thoroughfare = placemark.thoroughfare {
                    addressComponents.append(thoroughfare)
                }
                
                if let locality = placemark.locality {
                    addressComponents.append(locality)
                }
                
                if let country = placemark.country {
                    addressComponents.append(country)
                }
                
                let address = addressComponents.joined(separator: ", ")
                completion(address)
            } else {
                completion(nil)
            }
        }
    }
    
    struct MainFont: ViewModifier {
        var size: CGFloat
        func body(content: Content) -> some View {
            content
                .font(
                    Font.custom("SF Pro Display", size: size)
                        .weight(.medium)
                )
        }
    }
}

// MARK: Extensions

extension View {
    func mainFont(size: CGFloat) -> some View {
        modifier(Utilities.MainFont(size: size))
    }
}
