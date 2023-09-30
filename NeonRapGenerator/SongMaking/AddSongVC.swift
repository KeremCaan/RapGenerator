//
//  AddSongVC.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 29.08.2023.
//

import UIKit
import NeonSDK
import MultilineTextField

class AddSongVC: UIViewController, UIScrollViewDelegate, UITextViewDelegate {
    let backButton: UIButton = UIButton()
    let rapLabel: UILabel = UILabel()
    let promptField = MultilineTextField()
    let funButton: UIButton = UIButton()
    let happyButton: UIButton = UIButton()
    let loveButton: UIButton = UIButton()
    let sadButton: UIButton = UIButton()
    let sexyButton: UIButton = UIButton()
    let scrollView: UIScrollView = UIScrollView()
    let scrollingView: UIView = UIView()
    let nextButton: UIButton = UIButton()
    let optionButton1 = UIButton()
    let optionButton2: UIButton = UIButton()
    let optionButton3: UIButton = UIButton()
    let optionButton4: UIButton = UIButton()
    let vc = GeneratingLyricsVC()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }


    func configureUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(backButton)
        backButton.setImage(UIImage(named: "Vector"), for: .normal)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(24)
        }

        view.addSubview(rapLabel)
        rapLabel.text = "Prompt"
        rapLabel.font = UIFont(name: "Poppins-Bold", size: 21)
        rapLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }

        view.addSubview(nextButton)
        nextButton.setTitle("Continue", for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "Poppins", size: 21)
        nextButton.layer.cornerRadius = 17
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        nextButton.backgroundColor = .black
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(48)
            make.right.equalToSuperview().offset(-48)
            make.height.equalTo(56)
        }

        view.addSubview(optionButton1)
        optionButton1.setTitle("A diss about my friend Jamie who is spending too much time with his dog", for: .normal)
        optionButton1.titleLabel?.numberOfLines = 0
        optionButton1.setTitleColor(.black, for: .normal)
        optionButton1.addTarget(self, action: #selector(autopromptClicked(sender:)), for: .touchUpInside)
        optionButton1.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-72)
            make.left.equalToSuperview().offset(40)
            make.width.equalTo(147)
            make.height.equalTo(110)
        }
        
        view.addSubview(optionButton2)
        optionButton2.setTitle("A diss about my friend Jamie who is spending too much time with his dog", for: .normal)
        optionButton2.titleLabel?.numberOfLines = 0
        optionButton2.setTitleColor(.black, for: .normal)
        optionButton2.addTarget(self, action: #selector(autopromptClicked(sender:)), for: .touchUpInside)
        optionButton2.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-72)
            make.left.equalTo(optionButton1.snp.right).offset(32)
            make.width.equalTo(147)
            make.height.equalTo(110)
        }
        
        view.addSubview(optionButton3)
        optionButton3.setTitle("A diss about my friend Jamie who is spending too much time with his dog", for: .normal)
        optionButton3.titleLabel?.numberOfLines = 0
        optionButton3.setTitleColor(.black, for: .normal)
        optionButton3.addTarget(self, action: #selector(autopromptClicked(sender:)), for: .touchUpInside)
        optionButton3.snp.makeConstraints { make in
            make.bottom.equalTo(optionButton1.snp.top).offset(-16)
            make.left.equalToSuperview().offset(40)
            make.width.equalTo(147)
            make.height.equalTo(110)
        }
        
        view.addSubview(optionButton4)
        optionButton4.setTitle("A diss about my friend Jamie who is spending too much time with his dog", for: .normal)
        optionButton4.setTitleColor(.black, for: .normal)
        optionButton4.addTarget(self, action: #selector(autopromptClicked(sender:)), for: .touchUpInside)
        optionButton4.titleLabel?.numberOfLines = 0
        optionButton4.snp.makeConstraints { make in
            make.bottom.equalTo(optionButton2.snp.top).offset(-16)
            make.left.equalTo(optionButton3.snp.right).offset(32)
            make.width.equalTo(147)
            make.height.equalTo(110)
        }

        promptField.delegate = self
        view.addSubview(promptField)
        promptField.layer.borderColor = UIColor(red: 0.571, green: 0.571, blue: 0.571, alpha: 0.25).cgColor
        promptField.layer.borderWidth = 2
        promptField.layer.cornerRadius = 10
        promptField.autocorrectionType = .no
        promptField.placeholder = "Type your prompts"
        promptField.font = UIFont(name: "Poppins", size: 18)
        promptField.textAlignment = .left
        promptField.snp.makeConstraints { make in
            make.top.equalTo(rapLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(190)
        }

        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(promptField.snp.bottom).offset(32)
            make.left.right.equalToSuperview()
            make.height.equalTo(48)
        }

        scrollView.addSubview(scrollingView)
        scrollingView.translatesAutoresizingMaskIntoConstraints = false
        scrollingView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(scrollView.snp.height)
            make.width.equalTo(scrollView.snp.width).multipliedBy(1.3)
        }

        scrollingView.addSubview(funButton)
        funButton.setTitle("Fun", for: .normal)
        funButton.backgroundColor = UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1)
        funButton.layer.cornerRadius = 10
        funButton.addTarget(self, action: #selector(funTapped), for: .touchUpInside)
        funButton.setTitleColor(.white, for: .normal)
        funButton.snp.makeConstraints { make in
            make.top.equalTo(promptField.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(72)
            make.height.equalTo(48)
        }

        scrollingView.addSubview(happyButton)
        happyButton.setTitle("Happy", for: .normal)
        happyButton.backgroundColor = .white
        happyButton.layer.cornerRadius = 10
        happyButton.addTarget(self, action: #selector(happyTapped), for: .touchUpInside)
        happyButton.setTitleColor(.black, for: .normal)
        happyButton.snp.makeConstraints { make in
            make.top.equalTo(promptField.snp.bottom).offset(32)
            make.left.equalTo(funButton.snp.right).offset(16)
            make.width.equalTo(72)
            make.height.equalTo(48)
        }

        scrollingView.addSubview(loveButton)
        loveButton.setTitle("Love", for: .normal)
        loveButton.backgroundColor = .white
        loveButton.layer.cornerRadius = 10
        loveButton.addTarget(self, action: #selector(loveTapped), for: .touchUpInside)
        loveButton.setTitleColor(.black, for: .normal)
        loveButton.snp.makeConstraints { make in
            make.top.equalTo(promptField.snp.bottom).offset(32)
            make.left.equalTo(happyButton.snp.right).offset(16)
            make.width.equalTo(72)
            make.height.equalTo(48)
        }

        scrollingView.addSubview(sadButton)
        sadButton.setTitle("Sad", for: .normal)
        sadButton.layer.cornerRadius = 10
        sadButton.addTarget(self, action: #selector(sadTapped), for: .touchUpInside)
        sadButton.backgroundColor = .white
        sadButton.setTitleColor(.black, for: .normal)
        sadButton.snp.makeConstraints { make in
            make.top.equalTo(promptField.snp.bottom).offset(32)
            make.left.equalTo(loveButton.snp.right).offset(16)
            make.width.equalTo(72)
            make.height.equalTo(48)
        }

        scrollingView.addSubview(sexyButton)
        sexyButton.layer.cornerRadius = 10
        sexyButton.addTarget(self, action: #selector(sexyTapped), for: .touchUpInside)
        sexyButton.setTitle("Sexy", for: .normal)
        sexyButton.backgroundColor = .white
        sexyButton.setTitleColor(.black, for: .normal)
        sexyButton.snp.makeConstraints { make in
            make.top.equalTo(promptField.snp.bottom).offset(32)
            make.left.equalTo(sadButton.snp.right).offset(16)
            make.width.equalTo(72)
            make.height.equalTo(48)
        }
    }

    @objc func autopromptClicked(sender: UIButton) {
        promptField.text = sender.currentTitle
        nextButton.applyGradient(colours: [UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1), UIColor(red: 229 / 255.0, green: 65 / 255.0, blue: 87 / 255.0, alpha: 1.0), UIColor(red: 220 / 255.0, green: 45 / 255.0, blue: 150 / 255.0, alpha: 1.0)])
    }

    @objc func backTapped() {
        present(destinationVC: HomeVC(), slideDirection: .left)
    }

    @objc func funTapped() {
        funButton.setTitleColor(.white, for: .normal)
        funButton.backgroundColor = UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1)
        happyButton.setTitleColor(.black, for: .normal)
        happyButton.backgroundColor = .white
        loveButton.setTitleColor(.black, for: .normal)
        loveButton.backgroundColor = .white
        sadButton.setTitleColor(.black, for: .normal)
        sadButton.backgroundColor = .white
        sexyButton.setTitleColor(.black, for: .normal)
        sexyButton.backgroundColor = .white

        optionButton1.setTitle("A diss about my friend Jamie who is spending too much time with his dog", for: .normal)
        optionButton2.setTitle("A diss about my friend Jamie who is spending too much time with his dog", for: .normal)
        optionButton3.setTitle("A diss about my friend Jamie who is spending too much time with his dog", for: .normal)
        optionButton4.setTitle("A diss about my friend Jamie who is spending too much time with his dog", for: .normal)
    }
    @objc func happyTapped() {
        funButton.setTitleColor(.black, for: .normal)
        funButton.backgroundColor = .white
        happyButton.setTitleColor(.white, for: .normal)
        happyButton.backgroundColor = UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1)
        loveButton.setTitleColor(.black, for: .normal)
        loveButton.backgroundColor = .white
        sadButton.setTitleColor(.black, for: .normal)
        sadButton.backgroundColor = .white
        sexyButton.setTitleColor(.black, for: .normal)
        sexyButton.backgroundColor = .white

        optionButton1.setTitle("Happy text", for: .normal)
        optionButton2.setTitle("Happy text", for: .normal)
        optionButton3.setTitle("Happy text", for: .normal)
        optionButton4.setTitle("Happy text", for: .normal)
    }
    @objc func loveTapped() {
        funButton.setTitleColor(.black, for: .normal)
        funButton.backgroundColor = .white
        happyButton.setTitleColor(.black, for: .normal)
        happyButton.backgroundColor = .white
        loveButton.setTitleColor(.white, for: .normal)
        loveButton.backgroundColor = UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1)
        sadButton.setTitleColor(.black, for: .normal)
        sadButton.backgroundColor = .white
        sexyButton.setTitleColor(.black, for: .normal)
        sexyButton.backgroundColor = .white

        optionButton1.setTitle("Love text", for: .normal)
        optionButton2.setTitle("Love text", for: .normal)
        optionButton3.setTitle("Love text", for: .normal)
        optionButton4.setTitle("Love text", for: .normal)
    }
    @objc func sadTapped() {
        funButton.setTitleColor(.black, for: .normal)
        funButton.backgroundColor = .white
        happyButton.setTitleColor(.black, for: .normal)
        happyButton.backgroundColor = .white
        loveButton.setTitleColor(.black, for: .normal)
        loveButton.backgroundColor = .white
        sadButton.setTitleColor(.white, for: .normal)
        sadButton.backgroundColor = UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1)
        sexyButton.setTitleColor(.black, for: .normal)
        sexyButton.backgroundColor = .white

        optionButton1.setTitle("Sad text", for: .normal)
        optionButton2.setTitle("Sad text", for: .normal)
        optionButton3.setTitle("Sad text", for: .normal)
        optionButton4.setTitle("Sad text", for: .normal)
    }
    @objc func sexyTapped() {
        funButton.setTitleColor(.black, for: .normal)
        funButton.backgroundColor = .white
        happyButton.setTitleColor(.black, for: .normal)
        happyButton.backgroundColor = .white
        loveButton.setTitleColor(.black, for: .normal)
        loveButton.backgroundColor = .white
        sadButton.setTitleColor(.black, for: .normal)
        sadButton.backgroundColor = .white
        sexyButton.setTitleColor(.white, for: .normal)
        sexyButton.backgroundColor = UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1)

        optionButton1.setTitle("Sexy text", for: .normal)
        optionButton2.setTitle("Sexy text", for: .normal)
        optionButton3.setTitle("Sexy text", for: .normal)
        optionButton4.setTitle("Sexy text", for: .normal)
    }

    @objc func continueButtonTapped() {
        if promptField.text != "" {
            vc.requestedSong = promptField.text!
            self.present(destinationVC: vc, slideDirection: .right)
        }
    }

    @objc func userWrote() {
        if promptField.text != "" {
            nextButton.applyGradient(colours: [UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1), UIColor(red: 229 / 255.0, green: 65 / 255.0, blue: 87 / 255.0, alpha: 1.0), UIColor(red: 220 / 255.0, green: 45 / 255.0, blue: 150 / 255.0, alpha: 1.0)])
        } else {
            nextButton.backgroundColor = .black
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        userWrote()
    }

}


