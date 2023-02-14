//
//  RegisterViewViewModel.swift
//  TwitterAndFirebase
//
//  Created by Gustavo da Silva Braghin on 02/02/23.
//

import Foundation
import Firebase
import Combine

// Marked as final class means that no inheritance is allowed
// ObservableObject is a type of object that has a publisher which emits the var value before it really changes.
// https://developer.apple.com/documentation/combine/observableobject

final class AuthenticationViewModel: ObservableObject {
    
    @Published var email: String?
    @Published var password: String?
    @Published var isAuthenticationFormValid: Bool = false
    @Published var user: User?
    private var subscriptions: Set<AnyCancellable> = []
    
    func validateAuthenticationForm() {
        guard let email = email,
              let password = password else {
            isAuthenticationFormValid = false
                  return
              }
        isAuthenticationFormValid = isValidEmail(email) && password.count >= 8
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func createUser() {
        guard let email = email,
              let password = password else { return }
        
        AuthManager.shared.registerUser(with: email, password: password)
            .sink { _ in
                
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &subscriptions)

    }
    
    
}
