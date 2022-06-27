//
//  RestaurantView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 19/06/22.
//

import SwiftUI
import CoreLocationUI
import CoreLocation

struct RestaurantView: View {
    
    @State private var str = ""
    @State private var presentGPS = false
    
    @StateObject var locationManager = LocationManager()

    @FetchRequest(sortDescriptors: [])
    private var ristoranti: FetchedResults<Ristorante>

    var body: some View {
        NavigationView {
            List {
                ForEach(ristoranti.filter( { str == "" ? true : $0.nome?.contains(str) ?? true } )) { ristorante in
                    NavigationLink {
                        RestaurantDetailView(ristorante: ristorante)
                            .navigationTitle(ristorante.unwrappedNome)
                    } label: {
                        HStack {
                            Image(uiImage: ristorante.image)
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 50, height: 50)
                                .padding(.trailing)
                            Text(ristorante.unwrappedNome)
                                .font(.title2)
                        }
                    }
                }
                .navigationTitle("Ristoranti")
                .navigationBarTitleDisplayMode(.large)
            }
            .toolbar {
                ToolbarItem {
                    LocationButton(.currentLocation) {
                        locationManager.requestLocation()
                        presentGPS.toggle()
                    }
                    .foregroundColor(.white)
                    .cornerRadius(50)
                    .labelStyle(.iconOnly)
                    .symbolVariant(.fill)
                }
            }
            .searchable(text: $str, prompt: "Cerca")
            .disableAutocorrection(true)
            .fullScreenCover(isPresented: $presentGPS) {
                GPSView(isPresented: $presentGPS)
                    .environmentObject(locationManager)
            }
        }
    }
}

struct RestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
