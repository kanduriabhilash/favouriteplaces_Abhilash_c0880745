//
//  mapViewController.swift
//  favouriteplaces_Abhilash_c0880745
//
//  Created by user223764 on 1/24/23.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the mapView's delegate
        mapView.delegate = self
        // Ask for user's location permission
        locationManager.requestWhenInUseAuthorization()
        // Start updating the user's location
        locationManager.startUpdatingLocation()
        // Add the mapView to the view hierarchy
        view.addSubview(mapView)
        // Add a button to allow the user to add their current location to their favorites
        let addFavoriteButton = UIButton(type: .system)
        addFavoriteButton.setTitle("Add to favorites", for: .normal)
        addFavoriteButton.addTarget(self, action: #selector(addCurrentLocationToFavorites), for: .touchUpInside)
        view.addSubview(addFavoriteButton)
        // Fetch and display the user's favorite locations
        fetchAndDisplayFavorites()
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    @objc func addCurrentLocationToFavorites() {
        guard let currentLocation = locationManager.location else { return }
        let newFavorite = Mydata(context: managedObjectContext)
        newFavorite.latitude = currentLocation.coordinate.latitude
        newFavorite.longitude = currentLocation.coordinate.longitude
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving favorite: \(error)")
        }
    }
    
    func fetchAndDisplayFavorites() {
        let fetchRequest: NSFetchRequest<Mydata> = Mydata.fetchRequest()
        do {
            let favorites = try managedObjectContext.fetch(fetchRequest)
            for favorite in favorites {
                let favoriteCoordinate = CLLocationCoordinate2D(latitude: favorite.latitude, longitude: favorite.longitude)
                let favoriteAnnotation = MKPointAnnotation()
                favoriteAnnotation.coordinate = favoriteCoordinate
                mapView.addAnnotation(favoriteAnnotation)
            }
        } catch {
            print("Error fetching favorites: \(error)")
        }
    }
}

class DraggablePin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
func loadFavorites() {
        let request: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        do {
            let favorites = try context.fetch(request)
            for favorite in favorites {
                let coordinate = CLLocationCoordinate2D(latitude: favorite.latitude, longitude: favorite.longitude)
                let draggablePin = DraggablePin(coordinate: coordinate, title: favorite.name)
                mapView.addAnnotation(draggablePin)
            }
        } catch {
            print("Error loading favorites: \(error)")
        }
    }

    func saveFavorite(coordinate: CLLocationCoordinate2D, title: String) {
        let favorite = Favorites(context: context)
        favorite.name = title
        favorite.latitude = coordinate.latitude
        favorite.longitude = coordinate.longitude
        do {
            try context.save()
        } catch {
            print("Error saving favorite: \(error)")
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let annotationView = MKMarkerAnnotationView()
        annotationView.markerTintColor = .systemPink
        return annotationView
    }
}
