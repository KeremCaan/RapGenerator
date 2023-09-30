//
//  GradientButton.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 3.09.2023.
//

import UIKit

class ActualGradientButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1).cgColor, UIColor(red: 229 / 255.0, green: 65 / 255.0, blue: 87 / 255.0, alpha: 1.0).cgColor, UIColor(red: 220 / 255.0, green: 45 / 255.0, blue: 150 / 255.0, alpha: 1.0).cgColor]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        l.cornerRadius = 16
        layer.insertSublayer(l, at: 0)
        return l
    }()
}
