//
//  EditPresenter.swift
//  TodoList
//
//  Created by admin on 28/09/2022.
//

import Foundation
protocol EditPresenterView: AnyObject {
    func showList(_ data: Note)
}

class EditPresenter {
    weak var view: EditPresenterView?
     var data: Note
    
    init(with view: EditPresenterView, data: Note) {
        self.view = view
        self.data = data
    }
    func getList() {
        view?.showList(data)
    }
    
}
