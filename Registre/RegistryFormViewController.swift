//
//  RegistryFormViewController.swift
//  Registre
//
//  Created by user210579 on 1/10/22.
//

import UIKit

class RegistryFormViewController: UIViewController {

    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var texTFieldAddress: UITextField!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var imageViewRegistry: UIImageView!
    @IBOutlet weak var buttonAddEdit: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var registry: Registry?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let registry = registry {
            title = "Editar"
            textFieldTitle.text = registry.title
            texTFieldAddress.text = registry.address
            textViewDescription.text = registry.registryDescription
            if let image = registry.image {
                imageViewRegistry.image = UIImage(data: image)
            }
            buttonAddEdit.setTitle("Alterar", for: .normal)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else {return}
        
        scrollView.contentInset.bottom = keyboardFrame.size.height - view.safeAreaInsets.bottom
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardFrame.size.height - view.safeAreaInsets.bottom
    }
    
    @objc func keyboardWillHide() {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    @IBAction func selectImage(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar imagem", message: "De onde você deseja escolher escolher a imagem?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default) { _ in
                self.selectPicture(sourceType: .camera)
            }
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { _ in
            self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let albumAction = UIAlertAction(title: "Álbum de fotos", style: .default) { _ in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(albumAction)

        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func save(_ sender: UIButton) {
        let date = Date()
        print(date)

        if registry == nil {
            registry = Registry(context: context)
        }
        
        registry?.title = textFieldTitle.text
        registry?.address = texTFieldAddress.text
        registry?.registryDescription = textViewDescription.text
        registry?.image = imageViewRegistry.image?.jpegData(compressionQuality: 0.9)
        registry?.date = date
        
        try? context.save()
        navigationController?.popViewController(animated: true)
    }
}

extension RegistryFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageViewRegistry.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}
