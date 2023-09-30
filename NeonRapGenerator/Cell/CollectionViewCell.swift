//
//  ViewController.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 29.08.2023.
//

import UIKit
import NeonSDK
import Firebase
import FirebaseAuth

class CollectionViewCell: NeonCollectionViewCell<SavedRaps> {

    var rapperInfoArr: [SavedRaps] = []
    let imageView: UIImageView = UIImageView()
    var rappersArr: [UIImage] = [UIImage(named: "img_rapper1")!, UIImage(named: "img_rapper2")!, UIImage(named: "img_rapper3")!, UIImage(named: "img_rapper4")!, UIImage(named: "img_rapper5")!, UIImage(named: "img_rapper6")!, UIImage(named: "img_rapper7")!, UIImage(named: "img_rapper8")!, UIImage(named: "img_rapper9")!, UIImage(named: "img_rapper10")!]
    var songsArr: [String] = []
    var titleArr: [String] = []
    var backingtrackArr: [String] = []
    let rapNameLabel: UILabel = UILabel()
    let playButton: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        contentView.clipsToBounds = true
        contentView.addSubview(rapNameLabel)
        rapNameLabel.textColor = .white
        rapNameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(8)
        }
        contentView.addSubview(playButton)
        playButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.right.equalToSuperview().offset(-8)
        }
    }

    override func configure(with rap: SavedRaps) {
        super.configure(with: rap)
        imageView.image = rappersArr[rap.rapper]
        rapNameLabel.text = rap.title
        playButton.image = UIImage(named: "btn_playRapper")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
}
