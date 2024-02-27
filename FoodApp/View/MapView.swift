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
        ZStack{
            VStack {
                MapViewContent(selectedResult: $selectedResult, route: $route, travelTime: $travelTime)
                
            }
            .onAppear {
                self.selectedResult = MKMapItem(placemark: MKPlacemark(coordinate: self.restaurantLocation))
            }
            VStack(alignment: .leading){
                (Text("The order will be delivered to you within ")
                    .font(Font.custom("Bebas Neue", size: 20))
                )
                +
                (Text("\(travelTime)")
                    .font(Font.custom("Bebas Neue", size: 20))
                    .foregroundColor(Color("AccentColor"))
                )
                
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background{
                Color(.white)
            }
            .cornerRadius(10)
            .padding(.horizontal,10)
            .offset(y:200)
            
            VStack(alignment: .leading){
                Text("Has Taken food")
                    .font(Font.custom("Bebas Neue", size: 30))
                    .padding(.bottom)
                Text("The driver is delivering the goods to you")
                    .font(Font.custom("Bebas Neue", size: 20))
                
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background{
                Color(.white)
            }
            .cornerRadius(10)
            .padding(.horizontal,10)
            .offset(y:300)
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
            Annotation("Shipper", coordinate: restaurantLocation, anchor: .top) {
                Image("motorbike")
                    .resizable()
                    .frame(width: 30,height: 30)
            }
            if let route = route {
                MapPolyline(route)
                    .stroke(Color("AccentColor"), lineWidth: 5)
            }
        }
        .onChange(of: selectedResult) {
            withAnimation(.easeInOut(duration: 3)) {
                getDirection()
            }
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
