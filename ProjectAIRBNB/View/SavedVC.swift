//
//  SavedVC.swift
//  ProjectAIRBNB
//
//  Created by Iqbal Karim on 27.12.2022.
//

import UIKit
import CLTypingLabel
import CoreData

class SavedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var savedPlacesTable: UITableView!
    var places = [PlaceCore]()
    
    override func viewDidAppear(_ animated: Bool) {
        reloadData()
    }
    
    @IBOutlet weak var mLabel: CLTypingLabel!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        if (places.count == 0){
            mLabel.isHidden = false
            mLabel.text = "You have no saved places currently"
            savedPlacesTable.isHidden = true
        }else{
            mLabel.isHidden = true
            savedPlacesTable.isHidden = false
        }
    }
    
    func reloadData(){
        print("hello")
        fetchData()
        savedPlacesTable.reloadData()
    }
    
    func fetchData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceCore")
        
        let sortDescriptor1 = NSSortDescriptor(key: "name", ascending: true)

        fetchRequest.sortDescriptors = [sortDescriptor1]
    
        do {
            let results = try context.fetch(fetchRequest)
            places = results as! [PlaceCore]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedTableCell", for: indexPath) as! SearchTVC
        
        let place: PlaceCore
        
        place = places[indexPath.row]
        
        cell.nameView!.text = place.name
        cell.categoryView!.text = place.category
        cell.mImageView!.image = UIImage(named: place.image!)
        cell.locationView!.text = place.location
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = savedPlacesTable.indexPathForSelectedRow {
            let place : PlaceCore
            
            place = places[indexPath.row]
            
            let controller = segue.destination as! DetailVC
            controller.mRecord = Record(name: place.name!, category: place.category!, description: place.desc!, image: place.image!, location: place.location!)
        }

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete  {
            context.delete(places[indexPath.row])
            
            // Delete it from people Array
            places.remove(at: indexPath.row)
            
            
            // Save your changes
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
            
            // Delete it from the Table View
            savedPlacesTable.deleteRows(at: [indexPath], with: .automatic)
            
            if (places.count == 0){
                mLabel.isHidden = false
                mLabel.text = "You have no saved places currently"
                savedPlacesTable.isHidden = true
            }else{
                mLabel.isHidden = true
                savedPlacesTable.isHidden = false
            }
        }
        
    }
}
