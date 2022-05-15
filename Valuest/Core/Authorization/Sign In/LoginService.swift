//
//  LoginService.swift
//  Valuest
//
//  Created by Arthur Olevsky on 25.03.2022.
//

import Foundation
import Combine
import FirebaseAuth

protocol LoginProtocol {
    var state: loginState { get }
    var loginCredentials: LoginCredentials { get }
    func userLogin()
}

enum loginState {
    case succesfull
    case failure(error: Error)
    case na
}

final class LoginService: ObservableObject, LoginProtocol {
    
    @Published var loginCredentials: LoginCredentials = LoginCredentials.new
    @Published var state: loginState = .na
    @Published var bannerData: BannerData = BannerData(title: "", message: "", type: .Regular)
    @Published var showBanner: Bool = false
    
    private var subscriptions = Set<AnyCancellable>()
    
    func userLogin() {
        
        func login() -> AnyPublisher<Void, Error> {
            
            Deferred {
                Future { promise in
                    Auth.auth().signIn(withEmail: self.loginCredentials.email, password: self.loginCredentials.password) { res, err in
                        if let err = err {
                            promise(.failure(err))
                        } else {
                            promise(.success(()))
                        }
                    }
                }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        }
        
        login().sink { res in
            print(res)
            switch res {
                case.failure(let err):
                    self.state = .failure(error: err)
                    self.bannerData = BannerData(title: "Failed to login", message: err.localizedDescription, type: .Error)
                    self.showBanner = true
                default: break
            }
        } receiveValue: { [weak self] in
            self?.state = .succesfull
        }
        .store(in: &subscriptions)

    }
}
