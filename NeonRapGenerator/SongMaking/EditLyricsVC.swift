//
//  EditLyricsVC.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 30.08.2023.
//

import UIKit
import NeonSDK

class EditLyricsVC: UIViewController {
    let backButton: UIButton = UIButton()
    let rapLabel: UILabel = UILabel()
    let songTF: UITextView = UITextView()
    let saveButton = ActualGradientButton()

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
        rapLabel.attributedText = NSAttributedString(string: "Edit Lyrics", attributes: [.font: UIFont(name: "Poppins-Bold", size: 21)])
        rapLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }

        view.addSubview(saveButton)
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = UIFont(name: "Poppins", size: 21)
        saveButton.layer.cornerRadius = 17
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.backgroundColor = UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(48)
            make.right.equalToSuperview().offset(-48)
            make.height.equalTo(56)
        }

        view.addSubview(songTF)
        songTF.autocorrectionType = .no
        songTF.isScrollEnabled = true
        songTF.snp.makeConstraints { make in
            make.top.equalTo(rapLabel.snp.bottom).offset(24)
            make.width.equalToSuperview()
            make.bottom.equalTo(saveButton.snp.top).offset(-16)
        }
    }

    @objc func backTapped() {
        self.dismiss(animated: true)
    }

    @objc func saveButtonTapped() {
        let vc = GeneratedVC()
        vc.songTF.text = self.songTF.text
        present(destinationVC: vc, slideDirection: .right)
    }

}
