//
//  RapperCollectionViewCell.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 31.08.2023.
//

import UIKit
import NeonSDK
import AVFoundation

class RapperCollectionViewCell: NeonCollectionViewCell<RapperModel> {

    let rapperImageView: UIImageView = UIImageView()
    var playButton: UIButton = UIButton()
    let label: UILabel = UILabel()
    let rapperNames: [String] = ["Mehmet", "Ahmet", "Omer", "Veysel", "Bora", "Kerem", "Baki", "Eren", "Canturk", "Gizem", "Bugra", "Yusuf", "Burak", "Yilmaz", "Oguzhan", "Eymen"]



    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    private func setupSubviews() {
        contentView.addSubview(rapperImageView)
        contentView.addSubview(playButton)
        contentView.addSubview(label)
        rapperImageView.contentMode = .scaleAspectFill
        rapperImageView.clipsToBounds = true
        rapperImageView.contentMode = .scaleAspectFit
        contentView.clipsToBounds = true
        playButton.setImage(UIImage(named: "btn_playRapper"), for: .normal)
        playButton.addTarget(self, action: #selector(playButtonTapped(sender:)), for: .touchUpInside)
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
        }
        playButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-10)
        }
    }

    override func configure(with rapper: RapperModel) {
        super.configure(with: rapper)
        rapperImageView.image = rapper.rapperImage
        label.text = rapper.rapperName
        playButton.tag = rapper.rapperNumber

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        rapperImageView.frame = contentView.bounds
    }

    func loadRadio(radioURL: String) {

        guard let url = URL.init(string: radioURL) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        player?.play()
    }

    @objc func playButtonTapped(sender: UIButton) {
        let vc = RapperVC()
        self.loadRadio(radioURL: songs[sender.tag])
        if sender.currentImage == UIImage(named: "btn_playRapper") {
            vc.nextButton.backgroundColor = UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1)
            sender.setImage(UIImage(named: "btn_pauseRapper"), for: .normal)
        } else if sender.currentImage == UIImage(named: "btn_pauseRapper") {
            vc.nextButton.backgroundColor = .black
            player?.pause()
            sender.setImage(UIImage(named: "btn_playRapper"), for: .normal)
        }

    }


}
