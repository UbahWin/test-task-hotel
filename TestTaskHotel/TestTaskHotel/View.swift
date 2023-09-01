//
//  View.swift
//  TestTaskHotel
//
//  Created by Иван Вдовин on 30.08.2023.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var appViewModel = AppViewModel(repository: MockData())
    
    var body: some View {
        NavigationStack {
            List(appViewModel.hotels) { hotel in
                HotelView(appViewModel: appViewModel, hotel: hotel)
            }
        }
        .navigationTitle("Hostels")
        .onAppear {
            appViewModel.getHotels()
        }
    }
}

struct HotelView: View {
    @StateObject var utilities = Utilities()
    @ObservedObject var appViewModel: AppViewModel<MockData>
    
    var hotel: Hotel
    
    @State var address = ""
    
    var body: some View {
        VStack {
            Image("1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
                .padding()
            VStack(alignment: .leading) {
                Text(hotel.name)
                    .mainFont(size: 22)
                Text(address)
                    .mainFont(size: 14)
                    .padding()
                    .foregroundStyle(.blue)
                Text("от \(hotel.price.description) ₽")
                    .mainFont(size: 30)
                Text("за тур с перелётом")
                    .font(Font.custom("SF Pro Display", size: 14))
                    .foregroundColor(Color(red: 0.51, green: 0.53, blue: 0.59))
                
            }
            .padding()
        }
        .onAppear {
            loadAdress()
        }
        .refreshable {
            loadAdress()
        }
    }
    
    func loadAdress() {
        utilities.getAddressFromCoordinates(latitude: hotel.location.latitude, longitude: hotel.location.longitude) { address in
            self.address = address ?? ""
        }
    }
}

struct RoomView: View {
    var room: Room
    
    var body: some View {
        Text(room.name)
    }
}

#Preview("Main") {
    ContentView(appViewModel: AppViewModel(repository: MockData()))
}
