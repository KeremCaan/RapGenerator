//
//  BeatsCollectionViewCell.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 31.08.2023.
//

import UIKit
import NeonSDK
import AVFoundation

var player: AVPlayer?
class BeatsCollectionViewCell: NeonCollectionViewCell<String> {

    let label: UILabel = UILabel()
    var playButton: UIButton = UIButton()
    let songsArr: [String] = []
    let imageView: UIImageView = UIImageView()
    var buttonCount = 0
    let finalVC = RapperVC()
    var lastButton = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    override func configure(with song: String) {
        super.configure(with: song)
        label.text = song
        playButton.tag = songNamesArr.firstIndex(of: song)!
        playButton.setImage(UIImage(named: "btn_play_beats"), for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setupSubviews() {
        contentView.addSubview(label)
        contentView.addSubview(playButton)
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
        playButton.addTarget(self, action: #selector(playButtonTapped(sender:)), for: .touchUpInside)
        playButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(24)
        }
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(playButton.snp.right).offset(16)
        }
        imageView.isHidden = true
        imageView.image = UIImage(named: "img_sound_wave")
        imageView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)

        }
    }

    @objc func playButtonTapped(sender: UIButton) {
        print(sender.tag)
        let vc = BeatsVC()
        self.loadRadio(radioURL: beatURL[sender.tag])
        if playButton.currentImage == UIImage(named: "btn_play_beats") {
            playButton.setImage(UIImage(named: "btn_pause"), for: .normal)
            imageView.isHidden = false
        } else if playButton.currentImage == UIImage(named: "btn_pause") {
            player?.pause()
            playButton.setImage(UIImage(named: "btn_play_beats"), for: .normal)
            imageView.isHidden = true
        }

    }

    func loadRadio(radioURL: String) {

        guard let url = URL.init(string: radioURL) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        player?.play()
    }
}
