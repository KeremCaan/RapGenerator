//
//  HomeVC.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 28.08.2023.
//

import UIKit
import NeonSDK
import Firebase
import FirebaseAuth

class HomeVC: UIViewController {
    let settingsButton: UIButton = UIButton()
    let rapLabel: UILabel = UILabel()
    let addButton: UIButton = UIButton()
    let startLabel: UILabel = UILabel()
    let generateLabel: UILabel = UILabel()
    let vc = Home2VC()


    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        FirestoreManager.getDocuments(path: [
                .collection(name: "\(Auth.auth().currentUser?.uid)")
        ], completion: { [self] documentID, documentData in
            vc.userInfoArr.append(SavedRaps(title: documentData["title"] as! String, rapper: documentData["rapper"] as! Int, song: documentData["song"] as! String, backingtrack: documentData["backing_track"] as! String, bpm: documentData["bpm"] as! Int))
            vc.uid.append(documentID)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.savedSongs()
        })
    }


    func configureUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(settingsButton)
        settingsButton.setImage(UIImage(named: "btn_settings"), for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        settingsButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-10)
        }
        
        view.addSubview(addButton)
        addButton.setImage(UIImage(named: "btn_generate"), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(400)
        }

        view.addSubview(startLabel)
        startLabel.textAlignment = .center
        startLabel.numberOfLines = 0
        startLabel.font = UIFont(name: "Poppins", size: 24)
        startLabel.text = "START HERE"
        startLabel.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        view.addSubview(generateLabel)
        generateLabel.textAlignment = .center
        generateLabel.numberOfLines = 0
        generateLabel.font = UIFont(name: "Poppins", size: 15)
        generateLabel.text = "Generate a rap song"
        generateLabel.snp.makeConstraints { make in
            make.top.equalTo(startLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }

        view.addSubview(rapLabel)
        rapLabel.text = "Rap Gene"
        rapLabel.font = UIFont(name: "Poppins", size: 21)
        rapLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
    }

    @objc func settingsTapped() {
        present(destinationVC: SettingsVC(), slideDirection: .right)
    }

    @objc func addButtonTapped() {
        present(destinationVC: AddSongVC(), slideDirection: .right)
    }

    func savedSongs() {
        if vc.userInfoArr.isEmpty != true {
            present(destinationVC: vc, slideDirection: .right)
        }
    }

}
