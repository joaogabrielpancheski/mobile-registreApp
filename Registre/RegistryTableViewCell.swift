//
//  RegistryTableViewCell.swift
//  Registre
//
//  Created by user210579 on 1/10/22.
//

import UIKit

class RegistryTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWith(_ registry: Registry) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "GMT-3")

        labelTitle.text = registry.title
        if let date = registry.date {
            labelDate.text = dateFormatter.string(from: date)
        }
    }

}
