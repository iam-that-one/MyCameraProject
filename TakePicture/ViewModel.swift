//
//  ViewModel.swift
//  TakePicture
//
//  Created by Abdullah Alnutayfi on 04/12/2021.
//

import UIKit
import CoreData
class ViewModel {
    var myimages : [MyImages] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    func getContext() -> NSManagedObjectContext{
        return appDelegate.persistentContainer.viewContext
    }
    func fetchData(){
        let fetchRequest = NSFetchRequest<MyImages>()
        let entity =
        NSEntityDescription.entity(forEntityName: "MyImages",in: getContext())!
        fetchRequest.entity = entity
        print(myimages)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MyImages")
        request.returnsObjectsAsFaults = false
        do {
            let result = try getContext().fetch(request)
            self.myimages = result as! [MyImages]
        } catch let error as NSError{
            print("something went wrong while fetching data \(error.userInfo)")
        }
    }
}
