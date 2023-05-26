//
//  Interactor.swift
//  Viper-Architecture-Practice
//
//  Created by Talha Batuhan Irmalı on 26.05.2023.
//

import Foundation

// object
// protocol
// ref to presenter
// https://jsonplaceholder.typicode.com/users

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
}

class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {return}
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.intetactorDidFetchUsers(with: .failure(fetchError.failed))
                return
            }
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.intetactorDidFetchUsers(with: .success(entities))
            }
            catch {
                self?.presenter?.intetactorDidFetchUsers(with: .failure(error))
            }
        }
        task.resume()
    }
}
