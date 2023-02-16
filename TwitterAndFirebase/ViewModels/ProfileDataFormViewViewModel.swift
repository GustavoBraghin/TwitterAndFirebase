//
//  ProfileDataFormViewViewModel.swift
//  TwitterAndFirebase
//
//  Created by Gustavo da Silva Braghin on 15/02/23.
//

import Foundation
import Combine

final class ProfileDataFormViewViewModel: ObservableObject {
    @Published var displayName: String?
    @Published var userName: String?
    @Published var bio: String?
    @Published var avatarPath: String?
}
