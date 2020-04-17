//
//  HeaderView.swift
//  iOS14-TL-StickyHeader
//
//  Created by Paul Solt on 4/17/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "98º"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 60.0, weight: .light)
        label.hasDropShadow = true
//                label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Rochester, NY"
        label.textColor = .white
        label.hasDropShadow = true
//                label.backgroundColor = .green
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var summaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Clear"
        label.textColor = .white
        label.hasDropShadow = true
//                label.backgroundColeor = .red
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "partly-cloudy-day")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    var systemSpace: CGFloat = 8
    var minHeight: CGFloat {
        return round(cityLabel.frame.height + summaryLabel.frame.height + systemSpace + safeAreaInsets.top + 1 + systemSpace)
        // FIXME: Why is this off by 1 pixel? Where odes it come from?
        // FIXME: Put it inside an inner stack view and get the height of that inner stack view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
         setUpViews()
         setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        backgroundColor = .systemBlue
//        alpha = 0.5
        isOpaque = false
        
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(summaryLabel)
        stackView.addArrangedSubview(temperatureLabel)
        addSubview(stackView)
        
        self.backgroundColor = .systemBlue
        
        layoutIfNeeded()

    }
    
    fileprivate func setUpConstraints() {
        iconImageView.addConstraints([
            iconImageView.widthAnchor.constraint(equalToConstant: 60),
            iconImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        let centerY = centerYAnchor.constraint(equalTo: stackView.centerYAnchor)
        centerY.priority = .defaultHigh // can break when at top
        
        let cityTopSpace = cityLabel.topAnchor.constraint(greaterThanOrEqualTo: self.layoutMarginsGuide.topAnchor, constant: 1)
        cityTopSpace.priority = .defaultHigh + 1
        
        addConstraints([
            self.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            centerY,
            cityTopSpace
        ])
    }

    func hideImage(alpha: CGFloat) {
        iconImageView.alpha = alpha
        temperatureLabel.alpha = alpha
    }
}
