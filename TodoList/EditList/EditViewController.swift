//
//  EditViewController.swift
//  TodoList
//
//  Created by admin on 28/09/2022.
//

import UIKit
protocol EditViewControllerDelegate {
    func editViewController(_ vc: EditViewController, data: Note)
}
class EditViewController: UIViewController {
    static func instance(_ data: Note) -> EditViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        vc.presenter = EditPresenter(with: vc, data: data)
        return vc
    }
    @IBOutlet private  var tfName: UITextField!
    @IBOutlet private var img: UIImageView!
    private var imagePicker = UIImagePickerController()
    var delegate: EditViewControllerDelegate?
    private var presenter: EditPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImage()
        presenter.getList()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    private func setupImage(){
        img.isUserInteractionEnabled = true
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(didTapOnEditImage))
        img.addGestureRecognizer(tapGes)
        
    }
    @objc func didTapOnEditImage(){
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        let chooseImage = UIAlertAction(title: "From Librabri", style: .default) { action in
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true)
        }
        let chooseFromCamera = UIAlertAction(title: "From Camera", style: .default) { formCamera in
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancek", style: .cancel, handler: nil)
        alert.addAction(chooseImage)
        alert.addAction(chooseFromCamera)
        alert.addAction(cancel)
        present(alert, animated: true)
        
    }
    @IBAction func didTapOn(_ sender: Any) {
        if tfName.text == "" {
            return
        }else{
            let newImage = img.image
            let date = Date()
            let item = Note(name: tfName.text!, img: newImage, date: date)
        delegate?.editViewController(self, data: item)
        }
    }
}
extension EditViewController: EditPresenterView {
    func showList(_ data: Note) {
        tfName.text = data.name
        img.image = data.img
    }
}

extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let newImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        img.image = newImage
        imagePicker.dismiss(animated: true)
    }
    
}
