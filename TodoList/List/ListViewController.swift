//
//  ViewController.swift
//  TodoList
//
//  Created by admin on 28/09/2022.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet private weak var listTable: UITableView!
    private lazy var presenter = ListPresenter(with: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupListTable()
        presenter.loadData()
    }
    private func setupListTable(){
        listTable.delegate = self
        listTable.dataSource = self
        listTable.tableFooterView = UIView()
        
    }
    
    @IBAction func didTap(_ sender: Any) {
        let vc = AddNewViewController.instance()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTable.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListsCell
        if let item = presenter.cellForRowAt(indexPath.row) {
            cell.updateUI(item)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = presenter.cellForRowAt(indexPath.row ) else {
            return
        }
        let vc = EditViewController.instance(item)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteList(index: indexPath.row)
        }
    }
    
}

extension ListViewController: ListPresenterView {
    func removelist(at index: Int) {
        listTable.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        
    }
    func addNewlist(_ data: [Note], count: Int) {
        let fristIndexPaths = tableView(listTable,numberOfRowsInSection: 0) - count
        var indexPaths: [IndexPath] = []
        for i in 0..<count {
            indexPaths.append(IndexPath(row: i + fristIndexPaths, section: 0))
        }
        listTable.insertRows(at: indexPaths, with: .automatic)
    }
    func editList(at index: Int) {
        listTable.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    func showLists() {
        listTable.reloadData()
    }
}
extension ListViewController: EditViewControllerDelegate {
    func editViewController(_ vc: EditViewController, data: Note) {
        if let indexPaths = listTable.indexPathForSelectedRow {
            presenter.editList(data, index: indexPaths.row)
        navigationController?.popViewController(animated: true)
    }
  }
}
extension ListViewController: AddNewViewControllerDelegate {
    func addNewViewController(_ vc: AddNewViewController, didAdd: [Note]) {
        presenter.addNew(didAdd)
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
