//
//  TweetComposeViewController.swift
//  TwitterAndFirebase
//
//  Created by Gustavo da Silva Braghin on 24/02/23.
//

import UIKit
import Combine

class TweetComposeViewController: UIViewController {
    
    private var viewModel = TweetComposeViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    private lazy var tweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .twitterBlueColor
        button.setTitle("Tweet", for: .normal)
        button.isEnabled = false
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white.withAlphaComponent(0.7), for: .disabled)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        return button
    }()
    
    private lazy var tweetContentTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 8
        textView.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        textView.text = "What's happening"
        textView.textColor = .gray
        textView.font = .systemFont(ofSize: 16)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Tweet"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapToCancel))
        tweetContentTextView.delegate = self
        
        view.addSubview(tweetButton)
        view.addSubview(tweetContentTextView)
        configureConstraints()
        bindViews()
    }
    
    private func bindViews() {
        viewModel.$isValidToTweet.sink { [weak self] state in
            self?.tweetButton.isEnabled = state
        }
        .store(in: &subscriptions)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUserData()
    }
    
    @objc private func didTapToCancel() {
        dismiss(animated: true)
    }
    
    private func configureConstraints() {
        let tweetButtonConstraints = [
            tweetButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -10),
            tweetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tweetButton.widthAnchor.constraint(equalToConstant: 150),
            tweetButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let tweetContentTextView = [
            tweetContentTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tweetContentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tweetContentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            tweetContentTextView.bottomAnchor.constraint(equalTo: tweetButton.topAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(tweetButtonConstraints)
        NSLayoutConstraint.activate(tweetContentTextView)
    }
}

extension TweetComposeViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray {
            textView.textColor = .label
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What's happening?"
            textView.textColor = .gray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.tweetContent = textView.text
        viewModel.validateToTweet()
    }
}
