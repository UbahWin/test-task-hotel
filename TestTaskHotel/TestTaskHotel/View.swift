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
            .navigationTitle("Отель")
        }
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
    @State var openHotel = false
    
    var body: some View {
        VStack {
            Image("1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
                .padding()
            VStack {
                VStack {
                    Text(hotel.name)
                        .font(.title)
                        .bold()
                    Text(address)
                        .foregroundStyle(.blue)
                }
                .padding(.bottom)
                HStack {
                    Text("от \(hotel.price.description) ₽")
                        .font(.title)
                    Text("за тур с перелётом")
                        .foregroundColor(.gray)
                }
                
            }
            .padding()
             
            Rectangle()
                .frame(width: .infinity, height: 2)
                .background(.gray)
            VStack {
                Text("Об отеле")
                    .font(.title)
            }
            .padding()
            
            HStack {
                ForEach(hotel.preferences, id: \.self) { preference in
                    Text(preference)
                        .lineLimit(1)
                        .foregroundColor(Color(red: 0.51, green: 0.53, blue: 0.59))
                }
                .padding()
                .background(Color(red: 0.98, green: 0.98, blue: 0.99))
                .cornerRadius(5)
            }
            .padding()
            
            Text(hotel.info)
                .padding()

            Button(action: {
                openHotel = true
            }, label: {
                Text("К выбору номера")
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            })
            .padding()
        }
        .onAppear {
            loadAdress()
        }
        .refreshable {
            loadAdress()
        }
        .fullScreenCover(isPresented: $openHotel) {
            NavigationStack {
                List(hotel.rooms) { room in
                    RoomView(room: room)
                }
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button(action: {
                            openHotel = false
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.black)
                        })
                    }
                }
            }
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
        VStack {
            Text(room.name)
        }
    }
}

#Preview("Main") {
    ContentView(appViewModel: AppViewModel(repository: MockData()))
}
