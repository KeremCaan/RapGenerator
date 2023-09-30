//
//  GeneratingSongVC.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 1.09.2023.
//

import UIKit
import NeonSDK

class GeneratingSongVC: UIViewController {
    let rapLabel: UILabel = UILabel()
    let rapperView: UIImageView = UIImageView()
    var rapperName: String = ""
    let rapperNameLabel: UILabel = UILabel()
    let rapNameLabel: UILabel = UILabel()
    var rapName: String = ""
    let lottie = LottieManager.createLottie(animation: .custom(name: "loading"))
    let waitLabel: UILabel = UILabel()
    var timer = Timer()
    var wholeSong: String = ""
    let songPlayer = SongVC()
    var songBPM: Int = 0
    var songBacktrack: String = ""
    var rapperNumber: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(goToOtherVC), userInfo: nil, repeats: false)
    }

    func configureUI() {

        view.backgroundColor = .systemBackground
        view.addSubview(rapLabel)
        rapLabel.text = "Generating Song"
        rapLabel.font = UIFont(name: "Poppins", size: 21)
        rapLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }

        view.addSubview(rapperView)
        rapperView.image = UIImage(named: "img_profileRapper")
        rapperView.snp.makeConstraints { make in
            make.top.equalTo(rapLabel.snp.bottom).offset(120)
            make.centerX.equalToSuperview()
        }

        view.addSubview(rapperNameLabel)
        rapperNameLabel.text = rapperName
        rapperNameLabel.font = UIFont(name: "Poppins-Bold", size: 19)
        rapperNameLabel.snp.makeConstraints { make in
            make.top.equalTo(rapperView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        view.addSubview(rapNameLabel)
        rapNameLabel.text = rapName
        rapNameLabel.snp.makeConstraints { make in
            make.top.equalTo(rapperNameLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }

        view.addSubview(lottie)
        lottie.snp.makeConstraints { make in
            make.top.equalTo(rapNameLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }

        view.addSubview(waitLabel)
        waitLabel.text = "Please wait while we are generating your song."
        waitLabel.numberOfLines = 0
        waitLabel.textAlignment = .center
        waitLabel.snp.makeConstraints { make in
            make.top.equalTo(lottie.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }

    }

    @objc func goToOtherVC() {
        songPlayer.backing_track = songBacktrack
        songPlayer.bpm = songBPM
        songPlayer.songLyrics = wholeSong
        songPlayer.songTitle = rapName
        songPlayer.rapperNumber = self.rapperNumber
        present(destinationVC: songPlayer, slideDirection: .right)
    }

}
