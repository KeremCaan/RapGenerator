//
//  SettingsVC.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 29.08.2023.
//

import UIKit
import NeonSDK
import RevenueCat

class SettingsVC: UIViewController {
    let backButton: UIButton = UIButton()
    let rapLabel: UILabel = UILabel()
    let premiumButton = ActualGradientButton()
    let tosButton: UIButton = UIButton()
    let contactButton: UIButton = UIButton()
    let privacyButton: UIButton = UIButton()
    let restoreButton: UIButton = UIButton()
    let helpButton: UIButton = UIButton()
    let premiumLabel: UILabel = UILabel()
    let tosLabel: UILabel = UILabel()
    let contactLabel: UILabel = UILabel()
    let privacyLabel: UILabel = UILabel()
    let restoreLabel: UILabel = UILabel()
    let helpLabel: UILabel = UILabel()
    let premiumImage: UIImageView = UIImageView()
    let tosImage: UIImageView = UIImageView()
    let contactImage: UIImageView = UIImageView()
    let privacyImage: UIImageView = UIImageView()
    let restoreImage: UIImageView = UIImageView()
    let helpImage: UIImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }


    func configureUI() {
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)

        view.addSubview(backButton)
        backButton.setImage(UIImage(named: "Vector"), for: .normal)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(24)
        }

        view.addSubview(rapLabel)
        rapLabel.text = "Settings"
        rapLabel.font = UIFont(name: "Poppins-Bold", size: 21)
        rapLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }

        view.addSubview(premiumButton)
        premiumButton.backgroundColor = .purple
        premiumButton.addTarget(self, action: #selector(premiumTapped), for: .touchUpInside)
        premiumButton.backgroundColor = .white
        premiumButton.setBackgroundImage(UIImage(named: "img_soundWave_Settings"), for: .normal)
        premiumButton.layer.cornerRadius = 10
        premiumButton.snp.makeConstraints { make in
            make.top.equalTo(rapLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(64)
        }

        premiumButton.addSubview(premiumLabel)
        premiumLabel.attributedText = NSAttributedString(string: "Get Premium", attributes: [.font: UIFont(name: "Poppins-Regular", size: 17)])
        premiumLabel.textColor = .white
        premiumLabel.numberOfLines = 0
        premiumLabel.textAlignment = .left
        premiumLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(60)
        }

        premiumButton.addSubview(premiumImage)
        premiumImage.image = UIImage(named: "btn_premium")
        premiumImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        if Neon.isUserPremium == true {
            premiumButton.isHidden = true
            view.addSubview(tosButton)
            tosButton.layer.cornerRadius = 10
            tosButton.addTarget(self, action: #selector(tosTapped), for: .touchUpInside)
            tosButton.backgroundColor = .white
            tosButton.snp.makeConstraints { make in
                make.top.equalTo(rapLabel.snp.bottom).offset(40)
                make.centerX.equalToSuperview()
                make.left.equalToSuperview().offset(24)
                make.right.equalToSuperview().offset(-24)
                make.height.equalTo(64)
            }
        } else {
            view.addSubview(tosButton)
            tosButton.layer.cornerRadius = 10
            tosButton.addTarget(self, action: #selector(tosTapped), for: .touchUpInside)
            tosButton.backgroundColor = .white
            tosButton.snp.makeConstraints { make in
                make.top.equalTo(premiumButton.snp.bottom).offset(24)
                make.centerX.equalToSuperview()
                make.left.equalToSuperview().offset(24)
                make.right.equalToSuperview().offset(-24)
                make.height.equalTo(64)
            }
        }

        tosButton.addSubview(tosLabel)
        tosLabel.attributedText = NSAttributedString(string: "Terms of Use", attributes: [.font: UIFont(name: "Poppins-Regular", size: 17)])
        tosLabel.textColor = .black
        tosLabel.numberOfLines = 0
        tosLabel.textAlignment = .left
        tosLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(91)
            
        }

        tosButton.addSubview(tosImage)
        tosImage.image = UIImage(named: "btn_right_arrow")
        tosImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }


        view.addSubview(contactButton)
        contactButton.layer.cornerRadius = 10
        contactButton.backgroundColor = .white
        contactButton.addTarget(self, action: #selector(contactTapped), for: .touchUpInside)
        contactButton.snp.makeConstraints { make in
            make.top.equalTo(tosButton.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(64)
        }

        contactButton.addSubview(contactLabel)
        contactLabel.attributedText = NSAttributedString(string: "Contact Us", attributes: [.font: UIFont(name: "Poppins-Regular", size: 17)])
        contactLabel.textColor = .black
        contactLabel.numberOfLines = 0
        contactLabel.textAlignment = .left
        contactLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-22)
            make.width.equalTo(115)
        }

        contactButton.addSubview(contactImage)
        contactImage.image = UIImage(named: "btn_right_arrow")
        contactImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }


        view.addSubview(privacyButton)
        privacyButton.layer.cornerRadius = 10
        privacyButton.backgroundColor = .white
        privacyButton.addTarget(self, action: #selector(privacyTapped), for: .touchUpInside)
        privacyButton.snp.makeConstraints { make in
            make.top.equalTo(contactButton.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(64)
        }

        privacyButton.addSubview(privacyLabel)
        privacyLabel.attributedText = NSAttributedString(string: "Privacy Policy", attributes: [.font: UIFont(name: "Poppins-Regular", size: 17)])
        privacyLabel.textColor = .black
        privacyLabel.numberOfLines = 0
        privacyLabel.textAlignment = .left
        privacyLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(22)
            make.width.equalTo(115)
        }

        privacyButton.addSubview(privacyImage)
        privacyImage.image = UIImage(named: "btn_right_arrow")
        privacyImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }


        view.addSubview(restoreButton)
        restoreButton.backgroundColor = .white
        restoreButton.layer.cornerRadius = 10
        restoreButton.addTarget(self, action: #selector(restoreTapped), for: .touchUpInside)
        restoreButton.snp.makeConstraints { make in
            make.top.equalTo(privacyButton.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(64)
        }

        restoreButton.addSubview(restoreLabel)
        restoreLabel.attributedText = NSAttributedString(string: "Restore Purchase", attributes: [.font: UIFont(name: "Poppins-Regular", size: 17)])
        restoreLabel.textColor = .black
        restoreLabel.numberOfLines = 0
        restoreLabel.textAlignment = .left
        restoreLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(22)
            make.width.equalTo(200)
        }

        restoreButton.addSubview(restoreImage)
        restoreImage.image = UIImage(named: "btn_right_arrow")
        restoreImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }


        view.addSubview(helpButton)
        helpButton.layer.cornerRadius = 10
        helpButton.backgroundColor = .white
        helpButton.addTarget(self, action: #selector(helpTapped), for: .touchUpInside)
        helpButton.snp.makeConstraints { make in
            make.top.equalTo(restoreButton.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(64)
        }

        helpButton.addSubview(helpLabel)
        helpLabel.attributedText = NSAttributedString(string: "Help", attributes: [.font: UIFont(name: "Poppins-Regular", size: 17)])
        helpLabel.textColor = .black
        helpLabel.numberOfLines = 0
        helpLabel.textAlignment = .left
        helpLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-22)
            make.width.equalTo(115)
        }

        helpButton.addSubview(helpImage)
        helpImage.image = UIImage(named: "btn_right_arrow")
        helpImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    

    @objc func backTapped() {
        present(destinationVC: HomeVC(), slideDirection: .left)
    }

    @objc func premiumTapped() {
        present(destinationVC: PaywallVC(), slideDirection: .right)
    }
    @objc func tosTapped() {
        print("tos tapped")
    }
    @objc func contactTapped() {
        print("contact us")
    }
    @objc func privacyTapped() {
        print("privacy tapped")
    }
    @objc func restoreTapped() {
        RevenueCatManager.restorePurchases(vc: self, animation: .loadingBar) {
            print("premium restored")
        } completionFailure: {
            print("error")
        }
    }
    @objc func helpTapped() {
        print("help tapped")
    }

}
