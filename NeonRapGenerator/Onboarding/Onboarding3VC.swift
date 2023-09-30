//
//  Onboarding3VC.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 28.08.2023.
//

import UIKit
import NeonSDK

class Onboarding3VC: UIViewController {
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
        imageView.image = UIImage(named: "img_onboarding3")
        imageView.backgroundColor = UIColor(patternImage: UIImage(named: "img_onboarding_background")!)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.centerX.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }
        
        view.addSubview(titleLabel)
        titleLabel.text = "Find Your Perfect Beat Match"
        titleLabel.attributedText = NSAttributedString(string: "Find Your Perfect Beat Match", attributes: [.font: UIFont(name: "Poppins", size: 25)])
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
        }
        
        view.addSubview(subtitleLabel)
        subtitleLabel.text = "Explore diverse beats to complement your lyrics, producing catchy tracks that get your friends grooving."
        subtitleLabel.attributedText = NSAttributedString(string: "Explore diverse beats to complement your lyrics, producing catchy tracks that get your friends grooving.", attributes: [.font: UIFont(name: "Poppins", size: 18)])
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
        }

        view.addSubview(pageControl)
        pageControl.image = UIImage(named: "progress3")
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(48)
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
        present(destinationVC: Onboarding4VC(), slideDirection: .right)
    }


}
