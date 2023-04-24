//
//  TripsVC.swift
//  ProjectAIRBNB
//
//  Created by Iqbal Karim on 26.12.2022.
//

import UIKit
import CLTypingLabel

class TripsVC: UIViewController {
    let mDataSource = DataSource()
    
    var selectedPlace : Record = Record()
    @IBOutlet weak var mBungalowsLabel: CLTypingLabel!
    @IBOutlet weak var mApartmentsLabel: CLTypingLabel!
    @IBOutlet weak var mHousesLabel: CLTypingLabel!
    @IBOutlet weak var mCollectionViewApartment: UICollectionView!
    @IBOutlet weak var mCollectionViewHouse: UICollectionView!
    @IBOutlet weak var mCollectionViewBungalows: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mDataSource.populate()
        mHousesLabel.text = "Houses"
        mBungalowsLabel.text = "Bungalows"
        mApartmentsLabel.text = "Apartments"
    }
}

extension TripsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! DetailVC
        controller.mRecord = selectedPlace 
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if (collectionView === mCollectionViewApartment){
            selectedPlace = (mDataSource.itemsInCategory(index: 1)[indexPath.row])
            performSegue(withIdentifier: "detailSegue", sender: self)
        } else if (collectionView === mCollectionViewHouse){
            selectedPlace = (mDataSource.itemsInCategory(index: 0)[indexPath.row])
            performSegue(withIdentifier: "detailSegue", sender: self)
        } else {
            selectedPlace = (mDataSource.itemsInCategory(index: 2)[indexPath.row])
            performSegue(withIdentifier: "detailSegue", sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView === mCollectionViewHouse){
            return mDataSource.numbeOfItemsInEachCategory(index: 0)
        }else if (collectionView === mCollectionViewApartment){
            return mDataSource.numbeOfItemsInEachCategory(index: 1)
        }else{
            return mDataSource.numbeOfItemsInEachCategory(index: 2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView === mCollectionViewHouse){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "houseCell", for: indexPath) as! HouseCVC
            let places: [Record] = mDataSource.itemsInCategory(index: 0)
            let place = places[indexPath.row]
            
            let name = place.name
            
            cell.imageView.image = UIImage(named:place.image)
            
            cell.nameView.text = name.capitalized
            
            return cell
        }else if (collectionView === mCollectionViewApartment) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "apartmentCell", for: indexPath) as! ApartmentsCVC
            let places: [Record] = mDataSource.itemsInCategory(index: 1)
            let place = places[indexPath.row]
            
            let name = place.name
            
            cell.imageView.image = UIImage(named:place.image)
            
            cell.nameView.text = name.capitalized
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bungalowsCell", for: indexPath) as! BungalowsCVC
            let places: [Record] = mDataSource.itemsInCategory(index: 2)
            let place = places[indexPath.row]
            
            let name = place.name
            
            cell.imageView.image = UIImage(named:place.image)
            
            cell.nameView.text = name.capitalized
            
            return cell
        }
    }
}
