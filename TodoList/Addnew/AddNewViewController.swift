//
//  AddNewViewController.swift
//  TodoList
//
//  Created by admin on 28/09/2022.
//

import UIKit
protocol AddNewViewControllerDelegate {
    func addNewViewController(_ vc: AddNewViewController, didAdd: [Note])
}
class AddNewViewController: UIViewController {
    static func instance() -> AddNewViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Addnew") as! AddNewViewController
        vc.presenter = AddNewPresenter(with: vc)
        return vc
    }
    
    var delegate: AddNewViewControllerDelegate!
    @IBOutlet private  var tfName: UITextField!
    @IBOutlet private var img: UIImageView!
    private  var presenter: AddNewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImage()

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    private func setupImage(){
        img.image = UIImage(named: "placeholder")
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(didTapOnchooseImage))
        img.addGestureRecognizer(tapGes)
    }
    @objc func didTapOnchooseImage(){
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        let chooseImage = UIAlertAction(title: "From librabri", style: .default) { action in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        }
        let cancelChooseImage = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(chooseImage)
        alert.addAction(cancelChooseImage)
        present(alert, animated: true)
    }
    @IBAction func didTap(_ sender: Any) {
        if tfName.text == "" {
           return
        }
        else {
            let image = img.image
            let date = Date()
            delegate.addNewViewController(self, didAdd: [Note(name: tfName.text!,img: image, date: date)])
        }
    }
}
extension AddNewViewController: AddNewPresenterView {
    
}

extension AddNewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let newImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        img.image = newImage
        dismiss(animated: true)
    }
    
}
