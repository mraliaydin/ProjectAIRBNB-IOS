//
//  SearchTVC.swift
//  ProjectAIRBNB
//
//  Created by Iqbal Karim on 27.12.2022.
//

import UIKit

class SearchTVC: UITableViewCell {

    @IBOutlet weak var locationView: UILabel!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var categoryView: UILabel!
    @IBOutlet weak var mImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
