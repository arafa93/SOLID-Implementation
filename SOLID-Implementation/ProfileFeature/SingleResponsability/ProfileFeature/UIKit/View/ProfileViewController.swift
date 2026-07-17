//
//  ProfileViewController.swift
//  SOLID-Implementation
//
//  Created by Mohamed Arafa on 16/07/2026.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let viewModel: ProfileViewModel
    private lazy var nameLanbel: UILabel = {
        let nameLbl = UILabel()
        return nameLbl
    }()
    
    private lazy var emailLabel: UILabel = {
        let emailLbl = UILabel()
        return emailLbl
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        return activityIndicator
    }()
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.onAppear()
    }
    
    private func setupUI() {
        self.view.addSubview(nameLanbel)
        self.view.addSubview(emailLabel)
    }
    
    private func bindViewModel() {
        viewModel.onStateChange = { [weak self] state in
            self?.onAppear(state)
        }
    }
    
    private func onAppear(_ state: ProfileViewModel.Status) {
        switch state {
        case .idel:
            break
        case .loading:
            activityIndicator.startAnimating()
        case .loaded(let profile):
            activityIndicator.stopAnimating()
            nameLanbel.text = profile.name
            emailLabel.text = profile.email
        case .faild(let error):
            activityIndicator.stopAnimating()
            showError(error.localizedDescription)
        }
    }
    
    private func showError( _ message: String) {
        
    }
    
}
