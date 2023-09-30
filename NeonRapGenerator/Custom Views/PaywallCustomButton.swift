//
//  PaywallCustomButton.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 8.09.2023.
//

import UIKit
import NeonSDK

class PaywallCustomButton: UIButton {
    let timePeriodLabel = UILabel()
    let priceLabel = UILabel()


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        addSubview(timePeriodLabel)
        timePeriodLabel.numberOfLines = 0
        timePeriodLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(5)
        }
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
