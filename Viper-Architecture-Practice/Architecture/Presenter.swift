//
//  Presenter.swift
//  Viper-Architecture-Practice
//
//  Created by Talha Batuhan Irmalı on 26.05.2023.
//

import Foundation

// Object
// protocol
// re to interactor, router, view

enum fetchError: Error {
    case failed
}

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func intetactorDidFetchUsers(with result: Result<[User],Error>)
}

class UserPresenter: AnyPresenter {
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
    
    var view: AnyView?
    
    
    func intetactorDidFetchUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let user):
            view?.update(with: user)
        case .failure(let failure):
            view?.update(with: "Something Wrong")
        }
    }
}
