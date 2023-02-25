//
//  TweetComposeViewViewModel.swift
//  TwitterAndFirebase
//
//  Created by Gustavo da Silva Braghin on 25/02/23.
//

import Foundation
import Combine
import FirebaseAuth

final class TweetComposeViewViewModel {
    
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var isValidToTweet: Bool = false
    @Published var error: String = ""
    private var user: TwitterUser?
    var tweetContent: String = ""
    
    func getUserData() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionUsers(retreive: userID)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] twitterUser in
                self?.user = twitterUser
            }
            .store(in: &subscriptions)
    }
    
    func validateToTweet() {
        isValidToTweet = !tweetContent.isEmpty
    }
}
