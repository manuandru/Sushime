//
//  GPSView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 22/06/22.
//

import SwiftUI
import MapKit
import CoreLocation
import CoreLocationUI
import UniformTypeIdentifiers

struct IdentifiablePlace: Identifiable {
    let id = UUID()
    let place: MKMapItem
}

struct GPSView: View {

    @Binding var isPresented: Bool
    @EnvironmentObject var locationManager: LocationManager
    
    @State var placeToShow: IdentifiablePlace?
    
    var body: some View {
        
        ZStack {
            Map(coordinateRegion: $locationManager.region, annotationItems: locationManager.places) { item in
                MapAnnotation(coordinate: item.place.placemark.coordinate) {
                    ZStack {
                        Circle()
                            .fill(.red)
                        Image(systemName: "mappin")
                    }
                    .frame(width: 30, height: 30)
                    .onTapGesture { placeToShow = item }
                    // MARK: warning -> cannot present a sheet over a sheet
                    .sheet(item: $placeToShow) { place in
                        PlaceDetail(placeToShow: place)
                    }
                }
            }
            
            VStack {
                HStack {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                    }
                    .frame(height: 30)
                    .padding([.top])
                    Spacer()
                }
                .padding([.top])
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea()
        
    }
    
    struct PlaceDetail: View {
        
        var placeToShow: IdentifiablePlace
        
        var body: some View {
            VStack(alignment: .center) {
                Text("\(placeToShow.place.name ?? "No name")")
                    .font(.largeTitle)
                    .padding()
                HStack {
                    if let phoneNumber = placeToShow.place.phoneNumber {
                        if let phoneUrl = URL(string: "tel:\(phoneNumber.filter({ $0.isNumber }))") {
                            Link(destination: phoneUrl) {
                                Image(systemName: "phone.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text(phoneNumber)
                            }
                        }
                    }
                }
                
                HStack {
                    if let url = placeToShow.place.url {
                        Link(destination: url) {
                            Image(systemName: "network")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text(url.absoluteString)
                        }
                    }
                }
                .padding()
            }
            .padding()
        }
    }
}

//struct GPSView_Previews: PreviewProvider {
//    static var previews: some View {
//        GPSView(isPresented: .constant(true))
//    }
//}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?
    @Published var region: MKCoordinateRegion = defaultRegion()
    
    @Published var places: [IdentifiablePlace] = []

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.first?.coordinate {
            location = coordinate
            region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
            fetchNewSushi()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined, .denied, .restricted: break
        case .authorizedAlways, .authorizedWhenInUse:
            withAnimation {
                requestLocation()
            }
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    private func fetchNewSushi() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Sushi"
        request.region = region

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("There was an error searching for: \(String(describing: request.naturalLanguageQuery)) error: \(error!)")
                return
            }

            for item in response.mapItems {
                withAnimation {
                    self.places.append(IdentifiablePlace(place: item))
                }
            }
        }
    }
    
    static func defaultRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 41, longitude: 10),
            latitudinalMeters: 1_000_000,
            longitudinalMeters: 1_000_000)
    }
}
