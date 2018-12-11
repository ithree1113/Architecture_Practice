//
//  NoteDetailViewController.swift
//  NoteApp-MVC
//
//  Created by ithree on 2018/10/24.
//  Copyright © 2018 Eddie. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailImageView: UIImageView!
    
    var note: Note?
    var didFinishUpdate: ((Note)->())?
    
    fileprivate var isNewImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTextView.text = note?.text
        
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addImage(_:)))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done(_:)))
        
        navigationItem.rightBarButtonItems = [doneButton, cameraButton]
    }
    
    @objc func done(_ sender: UIBarButtonItem) {
        note?.text = detailTextView.text
        if isNewImage {
            let uuid = UUID()
            note?.imageName = String(format: "%@.jpg", uuid.uuidString)
        }
        didFinishUpdate?(note!)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addImage(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension NoteDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            detailImageView.image = image
            isNewImage = true
        }
        dismiss(animated: true, completion: nil)
    }
    
}
