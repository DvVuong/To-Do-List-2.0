//
//  ListPresenter.swift
//  TodoList
//
//  Created by admin on 28/09/2022.
//

import Foundation
import CloudKit
protocol ListPresenterView: AnyObject {
    func showLists()
    func editList( at index: Int)
    func addNewlist(_ data: [Note], count: Int)
    func removelist(  at index: Int)
}
class ListPresenter {
    weak var view: ListPresenterView?
    private var list = [Note]()
    init( with view: ListPresenterView){
        self.view = view
    }
    func loadData() {
        list = DataManger.shareInstance.fetchData()
    }
    func numberOfRow() -> Int {
        return list.count
    }
    func cellForRowAt(_ index: Int) -> Note? {
        if index < 0 && index > numberOfRow() {
            return nil
        }
        return  list[index]
    }
    func editList(_ data: Note, index: Int){
        guard let id = cellForRowAt(index)?.id else{ return }
        list[index] = data
        DataManger.shareInstance.updateData(with: id, data)
        view?.editList(at: index)
    }
    func addNew(_ item: [Note]){
        DataManger.shareInstance.saveData(item)
        list.append(contentsOf: item)
        view?.addNewlist(item, count: item.count)
        
    }
    func deleteList(index: Int){
        guard let id = cellForRowAt(index)?.id else{ return }
        DataManger.shareInstance.deleteObject(at: id)
        list.remove(at: index)
        view?.removelist(at: index)
        
    }
    
}
