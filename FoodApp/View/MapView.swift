// MapView.swift
// FoodApp

import SwiftUI
import MapKit

struct MapView: View {
    @State private var selectedResult: MKMapItem?
    @State private var route: MKRoute?
    @State private var travelTime: String = ""
    private let userLocation = CLLocationCoordinate2D(
        latitude: 10.725659,
        longitude: 106.655531
    )
    private let restaurantLocation = CLLocationCoordinate2D(
        latitude: 10.777470,
        longitude: 106.66305
    )
    var body: some View {
        VStack {
            MapViewContent(selectedResult: $selectedResult, route: $route, travelTime: $travelTime)
            if !travelTime.isEmpty {
                Text("Travel Time: \(travelTime)")
            }
        }
        .onAppear {
            self.selectedResult = MKMapItem(placemark: MKPlacemark(coordinate: self.restaurantLocation))
        }
    }
}

struct MapViewContent: View {
    private let userLocation = CLLocationCoordinate2D(
        latitude: 10.725659,
        longitude: 106.655531
    )
    private let restaurantLocation = CLLocationCoordinate2D(
        latitude: 10.777470,
        longitude: 106.66305
    )
    @Binding var selectedResult: MKMapItem?
    @Binding var route: MKRoute?
@Binding var travelTime: String
    var body: some View {
        Map(selection: $selectedResult) {
            Marker("Your Home", coordinate:userLocation)
            Marker("Driver", coordinate: restaurantLocation)
            if let route = route {
                MapPolyline(route)
                    .stroke(Color("AccentColor"), lineWidth: 5)
            }
        }
        .onChange(of: selectedResult) { _ in
            getDirection()
        }
    }

    func getDirection() {
        self.route = nil
        guard let selectedResult = selectedResult else { return }

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        request.destination = selectedResult

        Task {
            let direction = MKDirections(request: request)
            let response = try? await direction.calculate()
            route = response?.routes.first
            if let route = route {
                let travelTimeInSeconds = route.expectedTravelTime
                let formatter = DateComponentsFormatter()
                formatter.unitsStyle = .short
                formatter.allowedUnits = [.hour, .minute]
                travelTime = formatter.string(from: TimeInterval(travelTimeInSeconds)) ?? ""
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
