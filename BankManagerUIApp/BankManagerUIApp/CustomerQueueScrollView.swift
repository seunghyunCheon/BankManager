//
//  CustomerQueueScrollView.swift
//  BankManagerUIApp
//
//  Created by brody, christy, harry on 2023/03/14.
//

import UIKit

final class CustomerQueueScrollView: UIScrollView {
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.distribution = .fillEqually
        stackView.alignment = .top
        
        return stackView
    }()
    
    private let waitingQueueStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let processingQueueStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(contentStackView)
        configureContentStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContentStackView() {
        contentStackView.addArrangedSubview(waitingQueueStackView)
        contentStackView.addArrangedSubview(processingQueueStackView)
        
        let contentLayoutGuide = self.contentLayoutGuide
        let frameLayoutGuide = self.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: frameLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: frameLayoutGuide.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor)
        ])
    }
}
