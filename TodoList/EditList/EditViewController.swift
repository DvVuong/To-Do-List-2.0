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
    var delegate: EditViewControllerDelegate?
    private var presenter: EditPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getList()

        
    }
    @IBAction func didTapOn(_ sender: Any) {
        if tfName.text == "" {
            return
        }else{
            let item = Note(name: tfName.text!)
        delegate?.editViewController(self, data: item)
        }
    }
}
extension EditViewController: EditPresenterView {
    func showList(_ data: Note) {
        tfName.text = data.name
    }
    
    
}

