//
//  ViewController.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 28.08.2023.
//

import UIKit
import NeonSDK

class Onboarding1VC: UIViewController {
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
        imageView.image = UIImage(named: "img_onboarding1")
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        view.addSubview(titleLabel)
        titleLabel.attributedText = NSAttributedString(string: "Infinite Lyric Possibilities Await", attributes: [.font: UIFont(name: "Poppins", size: 25)])
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(72)
            make.right.equalToSuperview().offset(-72)
        }
        
        view.addSubview(subtitleLabel)
        subtitleLabel.attributedText = NSAttributedString(string: "Generate unique rap verses with ease, and let your friends marvel at your lyrical creativity.", attributes: [.font: UIFont(name: "Poppins", size: 18)])
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(56)
            make.right.equalToSuperview().offset(-56)
        }

        view.addSubview(pageControl)
        pageControl.image = UIImage(named: "progress1")
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
        present(destinationVC: Onboarding2VC(), slideDirection: .right)
    }

}

