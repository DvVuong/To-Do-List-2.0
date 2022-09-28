//
//  ListPresenter.swift
//  TodoList
//
//  Created by admin on 28/09/2022.
//

import Foundation
protocol ListPresenterView: AnyObject {
    func showLists()
    func editList(_ index: Int)
    func addNewlist(_ data: [Note])
}
class ListPresenter {
    weak var view: ListPresenterView?
    private var lists = [Note]()
    init( with view: ListPresenterView){
        self.view = view
    }
    func loadData() {
        let list1 = Note(name: "Home Work")
        let list2 = Note(name: "play Game")
        let list3 = Note(name: "Sleep")
        lists.append(list1)
        lists.append(list2)
        lists.append(list3)
    }
    func numberOfRow() -> Int {
        return lists.count
    }
    func cellForRowAt(_ index: Int) -> Note? {
        if index < 0 && index > numberOfRow() {
            return nil
        }
        return  lists[index]
    }
    func newList(_ data: Note, index: Int){
        lists[index] = data
        view?.editList(index)
    }
    func addNew(_ item: [Note]){
        
        view?.addNewlist(item)
        
    }
    
}
