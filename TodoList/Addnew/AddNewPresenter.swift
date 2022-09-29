//
//  AddNewPresenter.swift
//  TodoList
//
//  Created by admin on 28/09/2022.
//

import Foundation
protocol AddNewPresenterView: AnyObject {

}
class AddNewPresenter {
    weak var view: AddNewPresenterView?
    
    init(with view: AddNewPresenterView) {
        self.view = view
    }
    func initFruit(_ name: String, date: Date) -> Note  {
        let item = Note(name: name, date: date)
        return item
    }
}
