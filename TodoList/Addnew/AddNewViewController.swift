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
    private  var presenter: AddNewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func didTap(_ sender: Any) {
        if tfName.text == "" {
           return
        }
        else {
            let item = Note(name: tfName.text!)
           
            
        }
       
    }
}
extension AddNewViewController: AddNewPresenterView {
    
    
}
