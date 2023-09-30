//
//  GeneratingLyricsVC.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 29.08.2023.
//

import UIKit
import NeonSDK
import ChatGPTSwift

class GeneratingLyricsVC: UIViewController {
    let backButton: UIButton = UIButton()
    let rapLabel: UILabel = UILabel()
    let requestLabel: UILabel = UILabel()
    var requestedSong = ""
    let imageView: UIImageView = UIImageView()
    let countLabel: UILabel = UILabel()
    let proccessLabel: UILabel = UILabel()
    var count = 15
    var timer = Timer()
    let vc = GeneratedVC()


    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }


    func configureUI() {
        view.backgroundColor = .systemBackground
        let api = ChatGPTAPI(apiKey: "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")
        Task {
            do {
                let response = try await api.sendMessage(text: "Can you write a rap song for me ? The topic is: \(requestedSong)")
                vc.songTF.text = response
            } catch {
                print(error.localizedDescription)
            }
        }

        view.addSubview(backButton)
        backButton.setImage(UIImage(named: "Vector"), for: .normal)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(24)
        }

        view.addSubview(rapLabel)
        rapLabel.attributedText = NSAttributedString(string: "Generating Lyrics", attributes: [.font: UIFont(name: "Poppins", size: 21)])
        rapLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }

        view.addSubview(requestLabel)
        requestLabel.attributedText = NSAttributedString(string: "\(requestedSong)", attributes: [.font: UIFont(name: "Poppins", size: 17)])
        requestLabel.numberOfLines = 0
        requestLabel.textAlignment = .center
        requestLabel.snp.makeConstraints { make in
            make.top.equalTo(rapLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(48)
            make.right.equalToSuperview().offset(-48)
        }

        view.addSubview(imageView)
        imageView.image = UIImage(named: "img_soundWave_prompt")
        imageView.snp.makeConstraints { make in
            make.top.equalTo(requestLabel.snp.bottom).offset(80)
            make.left.equalToSuperview().offset(64)
            make.right.equalToSuperview().offset(-64)
        }

        view.addSubview(countLabel)
        countLabel.textAlignment = .center
        countLabel.attributedText = NSAttributedString(string: "15s Left.", attributes: [.font: UIFont(name: "Poppins", size: 21)])
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(proccessLabel)
        proccessLabel.attributedText = NSAttributedString(string: "Proccessing.", attributes: [.font: UIFont(name: "Poppins", size: 18)])
        proccessLabel.textAlignment = .center
        proccessLabel.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }

    @objc func backTapped() {
        present(destinationVC: AddSongVC(), slideDirection: .left)
    }

    @objc func countDown() {
        if count > 0 {
            countLabel.attributedText = NSAttributedString(string: "\(count - 1)s Left.", attributes: [.font: UIFont(name: "Poppins", size: 21)])
            count -= 1
        } else {
            timer.invalidate()
            present(destinationVC: vc, slideDirection: .right)
        }
    }
}
