//
//  Onboarding2VC.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 28.08.2023.
//

import UIKit
import NeonSDK

class Onboarding2VC: UIViewController {
    let imageView: UIImageView = UIImageView()
    let titleLabel: UILabel = UILabel()
    let subtitleLabel: UILabel = UILabel()
    let pageControl = UIImageView()
    let nextButton = ActualGradientButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    func configureUI() {

        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        imageView.image = UIImage(named: "img_onboarding2")
        imageView.backgroundColor = UIColor(patternImage: UIImage(named: "img_onboarding_background")!)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        view.addSubview(titleLabel)
        titleLabel.attributedText = NSAttributedString(string: "Choose Your Dream Rap Rapper", attributes: [.font: UIFont(name: "Poppins", size: 25)])
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
        }
        
        view.addSubview(subtitleLabel)
        subtitleLabel.attributedText = NSAttributedString(string: "Select your favorite rap artist to perform your custom lyrics, making your friends envious of your star collaboration.", attributes: [.font: UIFont(name: "Poppins", size: 18)])
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
        }

        view.addSubview(pageControl)
        pageControl.image = UIImage(named: "progress2")
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }

        view.addSubview(nextButton)
        nextButton.setAttributedTitle(NSAttributedString(string: "Next", attributes: [.font: UIFont(name: "Poppins", size: 21)])
                                      , for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 17
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(32)
            make.bottom.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(48)
            make.right.equalToSuperview().offset(-48)
            make.height.equalTo(56)
        }
    }

    @objc func nextButtonTapped() {
        present(destinationVC: Onboarding3VC(), slideDirection: .right)
    }


}
