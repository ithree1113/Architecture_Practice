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
        
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(cameraBtnDidTap(_:)))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done(_:)))
        
        navigationItem.rightBarButtonItems = [doneButton, cameraButton]
    }
    
    
    // MARK: - Selector
    @objc func done(_ sender: UIBarButtonItem) {
        note?.text = detailTextView.text
        if isNewImage, let photoFolderURL = getPhotoFolder() {
            saveImageTo(url: photoFolderURL)
        }
        didFinishUpdate?(note!)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cameraBtnDidTap(_ sender: UIBarButtonItem) {
        let imagePicker: UIImagePickerController = {
            let picker = UIImagePickerController()
            picker.sourceType = .savedPhotosAlbum
            picker.delegate = self
            return picker
        }()
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


// MARK: - Subroutine
extension NoteDetailViewController {
    func getPhotoFolder() -> URL? {
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let photoDirectoryURL = documentURL.appendingPathComponent("Photo", isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: photoDirectoryURL.path) {
            do {
                try FileManager.default.createDirectory(at: photoDirectoryURL, withIntermediateDirectories: false, attributes: nil)
                return photoDirectoryURL
            } catch {
                print(error)
                return nil
            }
        } else {
            return photoDirectoryURL
        }
    }
    
    func saveImageTo(url: URL) {
        let uuid = UUID()
        let imageName = String(format: "%@.jpg", uuid.uuidString)
        let imageURL = url.appendingPathComponent(imageName)
        let imageData = detailImageView.image!.jpegData(compressionQuality: 1)
        
        do {
            try imageData?.write(to: imageURL)
            if let oldImageName = note?.imageName, !oldImageName.isEmpty {
                let oldImageURL = url.appendingPathComponent(oldImageName)
                try FileManager.default.removeItem(at: oldImageURL)
            }
            note?.imageName = imageName
        } catch {
            print(error)
        }
    }
}
