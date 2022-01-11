//
//  RegistryViewController.swift
//  Registre
//
//  Created by user210579 on 1/10/22.
//

import UIKit

class RegistryViewController: UIViewController {
    
    
    @IBOutlet weak var imageViewRegistry: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    
    var registry: Registry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareScreen()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let registryFormViewController = segue.destination as? RegistryFormViewController {
            registryFormViewController.registry = registry
        }
    }
    
    func prepareScreen() {
        if let registry = registry {
            if let image = registry.image {
                imageViewRegistry.image = UIImage(data: image)
            }
            labelTitle.text = registry.title
            labelAddress.text = "Endereço: \(registry.address!)"
            textViewDescription.text = registry.registryDescription
        }
    }

}
