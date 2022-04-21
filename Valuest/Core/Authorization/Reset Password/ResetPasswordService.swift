//
//  ResetPasswordService.swift
//  Valuest
//
//  Created by Arthur Olevsky on 01.04.2022.
//

import Foundation
import FirebaseAuth
import Combine

final class ResetPassService: ObservableObject {
    
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
    
    @Published var bannerData: BannerData = BannerData(title: "", message: "", type: .Success)
    @Published var showBanner: Bool = false
    
    var isFormInvalid: Bool {
        if email.count >= 1 && isEmailValid == true {
            return false
        } else {
            return true
        }
    }
    
    private var subscriptions = Set<AnyCancellable>()

    
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
    func resetPassword() {
        func sendPasswordReset() -> AnyPublisher<Void, Error> {
            Deferred {
                Future { promise in
                    Auth.auth().sendPasswordReset(withEmail: self.email) { err in
                        if let err = err {
                            promise(.failure(err))
                        } else {
                            promise(.success(()))
                        }
                    }
                }
            }
            .eraseToAnyPublisher()
        }
        
        sendPasswordReset().sink { res in
            switch res {
                case .failure(let err):
                    self.bannerData = BannerData(title: "Failed to reset password", message: err.localizedDescription, type: .Error)
                    self.showBanner = true
                default: break
            }
        } receiveValue: {
            self.bannerData = BannerData(title: "Request sent", message: "Please check your email for letter with a link", type: .Success)
            self.showBanner = true
        }
        .store(in: &subscriptions)

    }
}
