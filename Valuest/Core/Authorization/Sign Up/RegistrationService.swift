//
//  RegistrationService.swift
//  Valuest
//
//  Created by Arthur Olevsky on 23.03.2022.
//

import Foundation
import Combine
import FirebaseAuth

enum RegistrationState {
    case na
    case successfull
    case failed(error: Error)
}

protocol RegistrationProtocol {
    var fullName: String { get }
    var email: String { get }
    var password: String { get }
    func userRegistration()
}

final class RegistrationService: ObservableObject, RegistrationProtocol {
        
    @Published var fullName: String = ""
    
    @Published var email: String = "" {
        didSet {
            if email.count >= 1 {
                self.validateEmail()
            } else {
                self.isEmailValid = true
            }
        }
    }
    @Published var isEmailValid: Bool = true
    
    @Published var password: String = "" {
        didSet {
            if password.count >= 1 {
                self.validatePassword()
            } else {
                self.isPasswordValid = true
            }
        }
    }
    @Published var isPasswordValid: Bool = true
    
    @Published var bannerData: BannerData = BannerData(title: "", message: "", type: .Regular)
    @Published var showBanner: Bool = false
    
    // Check if form valid or invalid
    var isFormInvalid: Bool {
        if password.count >= 1 && email.count >= 1 && fullName.count >= 1 {
            if isEmailValid && isPasswordValid {
                return false
            } else {
                return true
            }
        } else {
            return true
        }
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    var state: RegistrationState = .na
    
    // User registration - Firebase Email & Password
    func userRegistration() {
        
        func registration() -> AnyPublisher<Void, Error> {
            Deferred {
                Future { promise in
                    Auth.auth().createUser(withEmail: self.email, password: self.password) { result, error in
                        if let error = error {
                            promise(.failure(error))
                        } else {
                            if let uid = result?.user.uid {
                                NetworkManager.shared.createUser(userID: uid, fullName: self.fullName, email: self.email) { result in
                                    switch result {
                                        case .success(()):
                                            UserDefaults.standard.set(false, forKey: "isFirstLaunch")
                                            promise(.success(()))
                                        case .failure(let error):
                                            promise(.failure(error))
                                    }
                                }
                            } else {
                                promise(.failure(error!))
                            }
                        }
                    }
                }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        }
        
        registration().sink { [weak self] res in
            switch res{
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.state = .failed(error: error)
                    self?.bannerData = BannerData(title: "Failed to sign up", message: error.localizedDescription, type: .Error)
                    self?.showBanner = true
                default: break
            }
        } receiveValue: { [weak self] in
            self?.state = .successfull
        }.store(in: &subscriptions)
    }
    
    // Email Validation
    private func validateEmail() -> Void {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValid = emailTest.evaluate(with: email)
        if isValid {
            self.isEmailValid = true
        } else {
            self.isEmailValid = false
        }
    }
    
    // Password Validation
    private func validatePassword() -> Void {
        let passwordRegEx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        let isValidPassword = passwordPredicate.evaluate(with: self.password)
        if isValidPassword {
            self.isPasswordValid = true
        } else {
            self.isPasswordValid = false
        }
    }
}

