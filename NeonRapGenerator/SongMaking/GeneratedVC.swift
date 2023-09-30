//
//  GeneratedVC.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 29.08.2023.
//

import UIKit
import NeonSDK

class GeneratedVC: UIViewController {
    let backButton: UIButton = UIButton()
    let rapLabel: UILabel = UILabel()
    let songTitleLabel: UILabel = UILabel()
    let songLyricsLabel: UILabel = UILabel()
    let songTitleTF: UITextField = UITextField()
    let songTF: UITextView = UITextView()
    let nextButton = ActualGradientButton()
    let refreshButton: UIButton = UIButton()
    let editButton: UIButton = UIButton()
    let vc = EditLyricsVC()
    let otherVC = BeatsVC()
    var finalSong: String = ""
    var songTitle: String = ""

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
        rapLabel.attributedText = NSAttributedString(string: "Generating Lyrics", attributes: [.font: UIFont(name: "Poppins-Bold", size: 21)])
        rapLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }

        view.addSubview(refreshButton)
        refreshButton.setImage(UIImage(named: "btn_refresh"), for: .normal)
        refreshButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
        refreshButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-10)
        }

        view.addSubview(songTitleLabel)
        songTitleLabel.attributedText = NSAttributedString(string: "Song Title", attributes: [.font: UIFont(name: "Poppins", size: 18)])
        songTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(rapLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(40)
        }

        view.addSubview(songTitleTF)
        songTitleTF.placeholder = "Enter the title of your song."
        songTitleTF.autocorrectionType = .no
        songTitleTF.snp.makeConstraints { make in
            make.top.equalTo(songTitleLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(40)
            make.width.equalToSuperview()
        }

        view.addSubview(songLyricsLabel)
        songLyricsLabel.attributedText = NSAttributedString(string: "Song Lyrics", attributes: [.font: UIFont(name: "Poppins", size: 18)])
        songLyricsLabel.snp.makeConstraints { make in
            make.top.equalTo(songTitleTF.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(40)
        }

        view.addSubview(editButton)
        editButton.setImage(UIImage(named: "bnt_edit"), for: .normal)
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        editButton.snp.makeConstraints { make in
            make.top.equalTo(songTitleTF.snp.bottom).offset(24)
            make.right.equalToSuperview().offset(-24)
        }

        view.addSubview(nextButton)
        nextButton.setTitle("Continue", for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "Poppins", size: 21)
        nextButton.layer.cornerRadius = 17
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        nextButton.backgroundColor = UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(48)
            make.right.equalToSuperview().offset(-48)
            make.height.equalTo(56)
        }

        view.addSubview(songTF)
        songTF.autocorrectionType = .no
        songTF.isScrollEnabled = true
        songTF.isEditable = false
        songTF.snp.makeConstraints { make in
            make.top.equalTo(songLyricsLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(40)
            make.width.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top)
        }
    }

    @objc func backTapped() {
        present(destinationVC: AddSongVC(), slideDirection: .left)
    }
    @objc func continueButtonTapped() {
        if songTitleTF.text != "" {
            otherVC.finalTitle = songTitleTF.text!
            otherVC.finalSong = songTF.text
            present(destinationVC: otherVC, slideDirection: .right)
        }

    }


    @objc func refreshButtonTapped() {
        let blurView = NeonBlurView()
        blurView.colorTint = .black
        blurView.colorTintAlpha = 0.2
        blurView.blurRadius = 10
        blurView.scale = 1
        view.addSubview(blurView)
        blurView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalToSuperview()
        }
        let lottie = LottieManager.createLottie(animation: .loadingCircle3)
        view.addSubview(lottie)
        lottie.snp.makeConstraints({ make in
            make.center.equalToSuperview()
        })

        let refreshLabel: UILabel = UILabel()
        view.addSubview(refreshLabel)
        refreshLabel.attributedText = NSAttributedString(string: "Refreshing..", attributes: [.font: UIFont(name: "Poppins", size: 21)])
        refreshLabel.snp.makeConstraints { make in
            make.top.equalTo(lottie.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            blurView.isHidden = true
            lottie.isHidden = true
            refreshLabel.isHidden = true
        }
    }

    @objc func editButtonTapped() {
        vc.songTF.text = self.songTF.text
        present(destinationVC: vc, slideDirection: .right)
    }

}
