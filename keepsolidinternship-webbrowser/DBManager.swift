//
//  DBManager.swift
//  keepsolidinternship-webbrowser
//
//  Created by Alex Rudoi on 4/5/20.
//  Copyright © 2020 Alex Rudoi. All rights reserved.
//

import Foundation
import CoreData

class DBManager {
    static var instance = DBManager()

    func saveBookmark(title: String, text: String, completion: (_ finished: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let bookmark = Bookmark(context: managedContext)
        
        bookmark.bookmarkUrl = text
        bookmark.bookmarkTitle = title
        
        do {
            try managedContext.save()
            print("Data saved")
            completion(true)
        } catch {
            print("Failed to save data: ", error.localizedDescription)
            completion(false)
        }
    }
    
    func fetchData(completion: (_ complete: Bool, _ bookmarkArray: [Bookmark]?) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bookmark")
        do {
            let bookmarkArray = try  managedContext.fetch(request) as! [Bookmark]
            print("Data fetched, no issues")
            completion(true, bookmarkArray)
        } catch {
            print("Unable to fetch data: ", error.localizedDescription)
            completion(false, nil)
        }
        
    }
    
    func deleteData(bookmark: Bookmark) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(bookmark)
        do {
            try managedContext.save()
            print("Data Deleted")
            
        } catch {
            print("Failed to delete data: ", error.localizedDescription)
            
        }
    }
}


