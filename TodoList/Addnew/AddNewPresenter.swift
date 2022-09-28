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
}
