//
//  BeatsVC.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 30.08.2023.
//

import UIKit
import NeonSDK

var songNamesArr: [String] = []
var beatURL: [String] = []
var songPaths: [String] = []
var songBPM: [Int] = []

class BeatsVC: UIViewController {

    var collectionView = NeonCollectionView<String, BeatsCollectionViewCell>()

    var nextButton: UIButton = UIButton()
    let rapLabel: UILabel = UILabel()
    let backButton: UIButton = UIButton()
    var finalSong: String = ""
    var finalTitle: String = ""
    var finalVC = RapperVC()
    var lastCell = BeatsCollectionViewCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.shared.makeGetRequest()
        NotificationCenter.default.addObserver(self, selector: #selector(showResult(data:)), name: NSNotification.Name(rawValue: "beatNames"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showURLResult(data:)), name: NSNotification.Name(rawValue: "beatURL"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showBPMResult(data:)), name: NSNotification.Name(rawValue: "beatBPM"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showUUIDResult(data:)), name: NSNotification.Name(rawValue: "beatUUID"), object: nil)
        configureUI()

    }


    func configureUI() {

        view.backgroundColor = .systemBackground
        let vc = BeatsCollectionViewCell()
        collectionView = NeonCollectionView<String, BeatsCollectionViewCell>(
            objects: songNamesArr,
            itemsPerRow: 1,
            leftPadding: 20,
            rightPadding: 20,
            horizontalItemSpacing: 0,
            verticalItemSpacing: -200
        )

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: { [self] in
            collectionView.objects = songNamesArr
            print(songNamesArr)
        })

        view.addSubview(rapLabel)
        rapLabel.text = "Select Beat"
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

        view.addSubview(backButton)
        backButton.setImage(UIImage(named: "Vector"), for: .normal)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(24)
        }


        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).offset(-16)
            make.top.equalTo(rapLabel.snp.bottom).offset(32)
        }

        collectionView.didSelect = { [self] object, indexPath in
            if let cell = collectionView.cellForItem(at: indexPath) as? BeatsCollectionViewCell {
                print(object)
                cell.frame = CGRect(x: cell.frame.minX, y: cell.frame.minY, width: cell.frame.width, height: 150)
                lastCell.layer.borderWidth = 0
                lastCell = cell
                cell.layer.borderWidth = 5
                cell.layer.borderColor = UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1).cgColor
                cell.layer.cornerRadius = 10
            }
            self.finalVC.currentSongBPM = songBPM[indexPath.row]
            self.finalVC.backtrack = songPaths[indexPath.row]
            nextButton.applyGradient(colours: [UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1), UIColor(red: 229 / 255.0, green: 65 / 255.0, blue: 87 / 255.0, alpha: 1.0), UIColor(red: 220 / 255.0, green: 45 / 255.0, blue: 150 / 255.0, alpha: 1.0)])
        }

    }


    @objc func continueButtonTapped() {
        finalVC.finalTitle = self.finalTitle
        finalVC.finalSong = self.finalSong
        player?.pause()
        present(destinationVC: finalVC, slideDirection: .right)
    }

    @objc func backTapped() {
        player?.pause()
        self.dismiss(animated: true)
    }
    @objc func showResult(data: Notification) {
        if let userinfo = data.userInfo {
            songNamesArr = userinfo["beat"] as! [String]
        }
    }
    @objc func showBPMResult(data: Notification) {
        if let userinfo = data.userInfo {
            songBPM = userinfo["bpm"] as! [Int]
        }
    }
    @objc func showURLResult(data: Notification) {
        if let userinfo = data.userInfo {
            beatURL = userinfo["url"] as! [String]
        }
    }
    @objc func showUUIDResult(data: Notification) {
        if let userinfo = data.userInfo {
            songPaths = userinfo["uuid"] as! [String]
        }
    }

}


extension UIView {

    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }

    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.cornerRadius = 17
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }

}
