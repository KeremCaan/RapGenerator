//
//  SongVC.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 1.09.2023.
//

import UIKit
import AVFoundation
import NeonSDK

class SongVC: UIViewController {
    var bpm: Int = 0
    var rapperNumber: Int = 0
    var backing_track: String = ""
    let playButton: UIButton = UIButton()
    var songLyrics: String = ""
    var songTitle: String = ""
    let imageView: UIImageView = UIImageView()
    let nextButton = ActualGradientButton()
    let backButton: UIButton = UIButton()
    let songLabel: UILabel = UILabel()
    let rapperLabel: UILabel = UILabel()
    let playSongButton: UIButton = UIButton()
    let forwardButton: UIButton = UIButton()
    let backwardsButton: UIButton = UIButton()
    var firstTimeClicked = false
    let progressBar: UISlider = UISlider()
    let rapperNames: [String] = ["Mehmet", "Ahmet", "Omer", "Veysel", "Bora", "Kerem", "Baki", "Eren", "Canturk", "Gizem", "Bugra", "Yusuf", "Burak", "Yilmaz", "Oguzhan", "Eymen"]
    var pastTime: String = ""
    var remainingTime: String = ""
    var timer = Timer()
    let remainingTimeLabel: UILabel = UILabel()
    let pastTimeLabel: UILabel = UILabel()
    var countTime = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        loading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
            self.configureUI()
        })

    }

    func configureUI() {

        view.backgroundColor = .systemBackground

        view.addSubview(nextButton)
        nextButton.setTitle("Share", for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "Poppins", size: 21)
        nextButton.layer.cornerRadius = 17
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        nextButton.backgroundColor = UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(48)
            make.right.equalToSuperview().offset(-48)
            make.height.equalTo(56)
        }

        view.addSubview(playSongButton)
        playSongButton.setImage(UIImage(named: "btn_playSong"), for: .normal)
        playSongButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        playSongButton.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-56)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }

        view.addSubview(forwardButton)
        forwardButton.setImage(UIImage(named: "btn_forwardSong"), for: .normal)
        forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        forwardButton.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-64)
            make.left.equalTo(playSongButton.snp.right).offset(40)
            make.width.height.equalTo(80)
        }

        view.addSubview(backwardsButton)
        backwardsButton.setImage(UIImage(named: "btn_backSong"), for: .normal)
        backwardsButton.addTarget(self, action: #selector(backwardsButtonTapped), for: .touchUpInside)
        backwardsButton.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-64)
            make.right.equalTo(playSongButton.snp.left).offset(-40)
            make.width.height.equalTo(80)
        }

        view.addSubview(imageView)
        imageView.image = UIImage(named: "img_song")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }

        view.addSubview(songLabel)
        songLabel.attributedText = NSAttributedString(string: "\(songTitle)", attributes: [.font: UIFont(name: "Poppins", size: 25)])
        songLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }

        view.addSubview(rapperLabel)
        rapperLabel.attributedText = NSAttributedString(string: "\(rapperNames[rapperNumber])", attributes: [.font: UIFont(name: "Poppins", size: 21)])
        rapperLabel.snp.makeConstraints { make in
            make.top.equalTo(songLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }

        view.addSubview(progressBar)
        progressBar.minimumTrackTintColor = UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1)
        progressBar.setThumbImage(UIImage(named: "thumbimage"), for: .normal)
        progressBar.addTarget(self, action: #selector(sliderChanged(sender:)), for: .valueChanged)
        progressBar.maximumTrackTintColor = .black
        progressBar.layer.cornerRadius = 3
        progressBar.layer.masksToBounds = true
        progressBar.minimumValue = 0
        progressBar.maximumValue = 100
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(rapperLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(380)
            make.height.equalTo(6)
        }

        view.addSubview(pastTimeLabel)
        pastTimeLabel.attributedText = NSAttributedString(string: "00:00", attributes: [.font: UIFont(name: "Poppins", size: 13)])
        pastTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }

        view.addSubview(remainingTimeLabel)
        remainingTimeLabel.attributedText = NSAttributedString(string: "--:--", attributes: [.font: UIFont(name: "Poppins", size: 13)])
        remainingTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(16)
            make.right.equalToSuperview().offset(-16)
        }

        view.addSubview(backButton)
        backButton.setImage(UIImage(named: "WhiteVector"), for: .normal)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalToSuperview().offset(24)
        }
    }

    func loadRadio(radioURL: String) {

        guard let url = URL.init(string: radioURL) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        player?.play()
    }

    @objc func updateSlider() {
        guard (player?.currentItem!.duration) ?? CMTime(value: 0, timescale: 10000) >= .zero, ((player?.currentItem!.duration.seconds.isNaN) == false) else { return }
        let songTime = CMTimeGetSeconds((player?.currentItem!.duration) ?? CMTime(value: 0, timescale: 10000))
        progressBar.maximumValue = Float(Int(songTime))

        progressBar.setValue(Float(Int(CMTimeGetSeconds((player?.currentTime()) ?? CMTime(value: 0, timescale: 10000)))), animated: true)
        var (m, s) = secondsToMinutesSeconds(Int(progressBar.maximumValue))
        if s < 10 {
            remainingTimeLabel.attributedText = NSAttributedString(string: "\(m):0\(s)", attributes: [.font: UIFont(name: "Poppins", size: 13)])
        } else {
            remainingTimeLabel.attributedText = NSAttributedString(string: "\(m):\(s)", attributes: [.font: UIFont(name: "Poppins", size: 13)])
        }

        var (i, k) = secondsToMinutesSeconds(Int(progressBar.value))
        if k < 10 {
            pastTimeLabel.attributedText = NSAttributedString(string: "\(i):0\(k)", attributes: [.font: UIFont(name: "Poppins", size: 13)])
        } else {
            pastTimeLabel.attributedText = NSAttributedString(string: "\(i):\(k)", attributes: [.font: UIFont(name: "Poppins", size: 13)])
        }
    }

    @objc func buttonTapped() {
        if self.playSongButton.currentImage == UIImage(named: "btn_playSong") && firstTimeClicked == false {
            firstTimeClicked = true
            self.playSongButton.setImage(UIImage(named: "btn_pauseSong"), for: .normal)
            APIManager.shared.getSong(bpm: bpm, backing_track: backing_track, songLyrics: songLyrics)

            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        } else if self.playSongButton.currentImage == UIImage(named: "btn_playSong") && firstTimeClicked == true {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
            self.playSongButton.setImage(UIImage(named: "btn_pauseSong"), for: .normal)
            player?.play()
        } else if self.playSongButton.currentImage == UIImage(named: "btn_pauseSong") {
            timer.invalidate()
            self.playSongButton.setImage(UIImage(named: "btn_playSong"), for: .normal)
            player?.pause()
        }
    }

    @objc func shareButtonTapped() {
        let activityController = UIActivityViewController(activityItems: ["\(self.songTitle)"], applicationActivities: nil)
        present(activityController, animated: true)
    }
    @objc func backTapped() {
        self.present(destinationVC: HomeVC(), slideDirection: .left)
        player?.pause()
    }
    func secondsToMinutesSeconds(_ seconds: Int) -> (Int, Int) {
        return (seconds / 60, seconds % 60)
    }

    @objc func sliderChanged(sender: UISlider) {
        var newTime = Float64(sender.value)
        let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
        player!.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
    }

    @objc func forwardButtonTapped() {
        let seekDuration: Float64 = 15
        guard let duration = player?.currentItem?.duration else {
            return
        }
        let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
        let newTime = playerCurrentTime + seekDuration

        if newTime < (CMTimeGetSeconds(duration) - seekDuration) {

            let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
            player!.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)

        }
    }

    @objc func backwardsButtonTapped() {
        let seekDuration: Float64 = 15
        let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
        var newTime = playerCurrentTime - seekDuration

        if newTime < 0 {
            newTime = 0
        }
        let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
        player!.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)


    }

    func loading() {
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
        refreshLabel.attributedText = NSAttributedString(string: "Loading..", attributes: [.font: UIFont(name: "Poppins", size: 21)])
        refreshLabel.snp.makeConstraints { make in
            make.top.equalTo(lottie.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            blurView.isHidden = true
            lottie.isHidden = true
            refreshLabel.isHidden = true
        }
    }



}
