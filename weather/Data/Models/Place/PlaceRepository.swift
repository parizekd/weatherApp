//
//  PlaceRepository.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import Foundation
import CoreData
import UIKit

final class PlaceRepository {
    
    func savePlace(place: PlaceModel) -> PlaceModel? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        
        let dbObject = Place(context: context)
        dbObject.placeId = UUID()
        dbObject.city = place.city
        dbObject.country = place.country
        dbObject.isFavorite = true
        dbObject.lat = place.lat
        dbObject.lon = place.lon
        dbObject.name = place.name

        do {
            try context.save()
            NotificationCenter.default.post(name: .favoritesDidChange, object: nil)
            return PlaceModel(place: dbObject)
        } catch {
            print("Failed saving")
            return nil
        }
    }
    
    func getPlaces() -> [PlaceModel]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(Place.city), ascending: true, selector: #selector(NSString.caseInsensitiveCompare))
        fetchRequest.sortDescriptors = [sort]

        do {
            let contacts: [Place] = try context.fetch(fetchRequest)
            return contacts.map { PlaceModel(place: $0) }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func getPlaceById(place: PlaceModel) -> Place? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let placeId = place.id?.uuidString else {
            return nil
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "placeId == %@", placeId)
        do {
            let fetchedResults: [Place] = try context.fetch(fetchRequest)
            if let place = fetchedResults.first {
                return place
            }
        } catch {
            return nil
        }

        return nil
    }
    
    func removePlace(place: PlaceModel) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let context = appDelegate.persistentContainer.viewContext
        if let objectToDelete = self.getPlaceById(place: place) {
            do {
                context.delete(objectToDelete)
                try context.save()
                NotificationCenter.default.post(name: .favoritesDidChange, object: nil)
            } catch {
                return false
            }
            return true
        }
        return false
    }
}
