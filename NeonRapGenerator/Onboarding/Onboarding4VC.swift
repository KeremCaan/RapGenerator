//
//  Onboarding4VC.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 28.08.2023.
//

import UIKit
import NeonSDK
import Firebase
import FirebaseAuth

class Onboarding4VC: UIViewController {
    let imageView: UIImageView = UIImageView()
    let titleLabel: UILabel = UILabel()
    let subtitleLabel: UILabel = UILabel()
    let pageControl = UIImageView()
    let nextButton = ActualGradientButton()
    var userUid = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    func configureUI() {

        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        imageView.image = UIImage(named: "img_onboarding4")
        imageView.backgroundColor = UIColor(patternImage: UIImage(named: "img_onboarding_background")!)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(400)
        }
        
        view.addSubview(titleLabel)
        titleLabel.attributedText = NSAttributedString(string: "Share Your Rap Flair, Ignite Social Media", attributes: [.font: UIFont(name: "Poppins", size: 25)])
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
        }
        
        view.addSubview(subtitleLabel)
        subtitleLabel.attributedText = NSAttributedString(string: "Showcase your original rap creations on social media, captivating friends and followers with your undeniable talent.", attributes: [.font: UIFont(name: "Poppins", size: 18)])
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
        }

        view.addSubview(pageControl)
        pageControl.image = UIImage(named: "progress4")
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
        Auth.auth().signInAnonymously { authResult, error in
            guard let user = authResult?.user else { return }
        }
        present(destinationVC: PaywallVC(), slideDirection: .right)
    }


}
