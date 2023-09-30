//
//  PaywallVC.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 28.08.2023.
//

import UIKit
import NeonSDK
import FirebaseAuth

class PaywallVC: UIViewController, RevenueCatManagerDelegate {
    let imageView: UIImageView = UIImageView()
    let titleLabel: UILabel = UILabel()
    let continueButton: UIButton = UIButton()
    let legalView = NeonLegalView()
    let weeklyButton = PaywallCustomButton()
    let monthlyButton = PaywallCustomButton()
    let annualButton = PaywallCustomButton()
    var selectedPackage = ""
    let crossButton: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        packageFetched()
        isUserPremium()
        Neon.onboardingCompleted()
    }

    func configureUI() {

        view.backgroundColor = .systemBackground
        RevenueCatManager.delegate = self

        view.addSubview(imageView)
        imageView.image = UIImage(named: "img_inapp1")
        imageView.backgroundColor = UIColor(patternImage: UIImage(named: "img_inapp_background")!)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(88)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(220)
        }

        view.addSubview(crossButton)
        crossButton.setImage(UIImage(named: "xbutton"), for: .normal)
        crossButton.addTarget(self, action: #selector(crossTapped), for: .touchUpInside)
        crossButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(-8)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-10)
        }

        view.addSubview(titleLabel)
        titleLabel.attributedText = NSAttributedString(string: "Rap Your Stories & Share", attributes: [.font: UIFont(name: "Poppins", size: 25)])
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(72)
            make.right.equalToSuperview().offset(-72)
        }

        let subImage1 = UIImageView()
        view.addSubview(subImage1)
        subImage1.image = UIImage(named: "img_ADS")
        subImage1.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.width.height.equalTo(22)
            make.left.equalToSuperview().offset(32)
        }

        let subtitleLabel1: UILabel = UILabel()
        view.addSubview(subtitleLabel1)
        subtitleLabel1.attributedText = NSAttributedString(string: "Unlimited Songs: Unleash Your Rap Potential.", attributes: [.font: UIFont(name: "Poppins", size: 12)])
        subtitleLabel1.numberOfLines = 0
        subtitleLabel1.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.left.equalTo(subImage1.snp.right).offset(5)
        }

        let subImage2 = UIImageView()
        view.addSubview(subImage2)
        subImage2.image = UIImage(named: "img_speaker")
        subImage2.snp.makeConstraints { make in
            make.top.equalTo(subImage1.snp.bottom).offset(16)
            make.width.height.equalTo(22)
            make.left.equalToSuperview().offset(32)
        }

        let subtitleLabel2: UILabel = UILabel()
        view.addSubview(subtitleLabel2)
        subtitleLabel2.attributedText = NSAttributedString(string: "Enjoy Ad-Free, Uninterrupted Inspiration.", attributes: [.font: UIFont(name: "Poppins", size: 12)])
        subtitleLabel2.numberOfLines = 0
        subtitleLabel2.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel1.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.left.equalTo(subImage2.snp.right).offset(5)
        }

        let subImage3 = UIImageView()
        view.addSubview(subImage3)
        subImage3.image = UIImage(named: "img_T")
        subImage3.snp.makeConstraints { make in
            make.top.equalTo(subImage2.snp.bottom).offset(16)
            make.width.height.equalTo(22)
            make.left.equalToSuperview().offset(32)
        }

        let subtitleLabel3: UILabel = UILabel()
        view.addSubview(subtitleLabel3)
        subtitleLabel3.attributedText = NSAttributedString(string: "Inspire friends with your RAP songs.", attributes: [.font: UIFont(name: "Poppins", size: 12)])
        subtitleLabel3.numberOfLines = 0
        subtitleLabel3.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel2.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.left.equalTo(subImage3.snp.right).offset(5)
        }

        view.addSubview(weeklyButton)
        weeklyButton.addTarget(self, action: #selector(weeklyButtonTapped), for: .touchUpInside)
        weeklyButton.timePeriodLabel.attributedText = NSAttributedString(string: "Weekly", attributes: [.font: UIFont(name: "Poppins", size: 20)])
        weeklyButton.priceLabel.attributedText = NSAttributedString(string: "20$", attributes: [.font: UIFont(name: "Poppins", size: 20)])
        weeklyButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel3.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(48)
            make.right.equalToSuperview().offset(-48)
            make.height.equalTo(56)
        }

        view.addSubview(monthlyButton)
        monthlyButton.addTarget(self, action: #selector(monthlyButtonTapped), for: .touchUpInside)
        monthlyButton.timePeriodLabel.attributedText = NSAttributedString(string: "Monthly", attributes: [.font: UIFont(name: "Poppins", size: 20)])
        monthlyButton.priceLabel.attributedText = NSAttributedString(string: "30$", attributes: [.font: UIFont(name: "Poppins", size: 20)])
        monthlyButton.snp.makeConstraints { make in
            make.top.equalTo(weeklyButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(48)
            make.right.equalToSuperview().offset(-48)
            make.height.equalTo(56)
        }

        view.addSubview(annualButton)
        annualButton.addTarget(self, action: #selector(annualButtonTapped), for: .touchUpInside)
        annualButton.timePeriodLabel.attributedText = NSAttributedString(string: "Annual", attributes: [.font: UIFont(name: "Poppins", size: 20)])
        annualButton.priceLabel.attributedText = NSAttributedString(string: "50$", attributes: [.font: UIFont(name: "Poppins", size: 20)])
        annualButton.snp.makeConstraints { make in
            make.top.equalTo(monthlyButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(48)
            make.right.equalToSuperview().offset(-48)
            make.height.equalTo(56)
        }

        view.addSubview(continueButton)
        continueButton.setAttributedTitle(NSAttributedString(string: "Continue", attributes: [.font: UIFont(name: "Poppins", size: 21)]), for: .normal)
        continueButton.layer.cornerRadius = 17
        continueButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        continueButton.backgroundColor = .black
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(48)
            make.right.equalToSuperview().offset(-48)
            make.height.equalTo(56)
        }

        legalView.termsURL = "[https://www.neonapps.co/terms-of-use](https://www.neonapps.co/terms-of-use)"
        legalView.privacyURL = "[https://www.neonapps.co/privacy-policy](https://www.neonapps.co/privacy-policy)"
        legalView.restoreButtonClicked = {
            RevenueCatManager.restorePurchases(vc: self, animation: .loadingBar) {
                self.present(destinationVC: HomeVC(), slideDirection: .right)
            } completionFailure: {
                print("error")
            }
        }
        legalView.textColor = .black
        view.addSubview(legalView)
        legalView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }

    @objc func crossTapped() {
        present(destinationVC: HomeVC(), slideDirection: .right)
    }

    @objc func nextButtonTapped() {
        if selectedPackage == "Weekly" {
            RevenueCatManager.selectPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Weekly")
        } else if selectedPackage == "Monthly" {
            RevenueCatManager.selectPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Montly")
        } else if selectedPackage == "Annual" {
            RevenueCatManager.selectPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Annual")
        }

        RevenueCatManager.subscribe(animation: .loadingBar) {
            self.present(destinationVC: HomeVC(), slideDirection: .right)
        } completionFailure: {
            print("error")
        }

    }

    func isUserPremium() {
        if Neon.isUserPremium {
            present(destinationVC: HomeVC(), slideDirection: .right)
        }
    }

    @objc func weeklyButtonTapped() {
        continueButton.backgroundColor = UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1)
        monthlyButton.backgroundColor = .systemBackground
        annualButton.backgroundColor = .systemBackground
        annualButton.priceLabel.textColor = .black
        annualButton.timePeriodLabel.textColor = .black
        monthlyButton.timePeriodLabel.textColor = .black
        monthlyButton.priceLabel.textColor = .black
        weeklyButton.backgroundColor = UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1)
        weeklyButton.priceLabel.textColor = .white
        weeklyButton.timePeriodLabel.textColor = .white
        selectedPackage = "Weekly"
    }
    @objc func monthlyButtonTapped() {
        continueButton.backgroundColor = UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1)
        weeklyButton.backgroundColor = .systemBackground
        annualButton.backgroundColor = .systemBackground
        annualButton.priceLabel.textColor = .black
        annualButton.timePeriodLabel.textColor = .black
        weeklyButton.priceLabel.textColor = .black
        weeklyButton.timePeriodLabel.textColor = .black
        monthlyButton.backgroundColor = UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1)
        monthlyButton.timePeriodLabel.textColor = .white
        monthlyButton.priceLabel.textColor = .white
        selectedPackage = "Monthly"
    }
    @objc func annualButtonTapped() {
        continueButton.backgroundColor = UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1)
        monthlyButton.backgroundColor = .systemBackground
        weeklyButton.backgroundColor = .systemBackground
        monthlyButton.timePeriodLabel.textColor = .black
        monthlyButton.priceLabel.textColor = .black
        weeklyButton.priceLabel.textColor = .black
        weeklyButton.timePeriodLabel.textColor = .black
        annualButton.backgroundColor = UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1)
        annualButton.priceLabel.textColor = .white
        annualButton.timePeriodLabel.textColor = .white
        selectedPackage = "Annual"
    }
    func packageFetched() {

        if let price = RevenueCatManager.getPackagePrice(id: "com.neonapps.education.SwiftyStoreKitDemo.Weekly") {
        }

        if let weeklyPackage = RevenueCatManager.getPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Weekly") {
        }

        if let price = RevenueCatManager.getPackagePrice(id: "com.neonapps.education.SwiftyStoreKitDemo.Montly") {
        }

        if let monthlyPackage = RevenueCatManager.getPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Montly") {
        }

        if let price = RevenueCatManager.getPackagePrice(id: "com.neonapps.education.SwiftyStoreKitDemo.Annual") {
        }

        if let annualPackage = RevenueCatManager.getPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Annual") {
        }

    }


}


