//
//  RapperVC.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 29.08.2023.
//

import UIKit
import NeonSDK
import Firebase
import FirebaseAuth

var songs: [String] = []

class RapperVC: UIViewController {
    let nextButton: UIButton = UIButton()
    let rapLabel: UILabel = UILabel()
    let backButton: UIButton = UIButton()
    var collectionView = NeonCollectionView<RapperModel, RapperCollectionViewCell>()
    var rapperArr: [RapperModel] = [RapperModel(rapperName: "Mehmet", rapperImage: UIImage(named: "img_rapper1")!, rapperNumber: 0), RapperModel(rapperName: "Ahmet", rapperImage: UIImage(named: "img_rapper2")!, rapperNumber: 1), RapperModel(rapperName: "Omer", rapperImage: UIImage(named: "img_rapper3")!, rapperNumber: 2), RapperModel(rapperName: "Veysel", rapperImage: UIImage(named: "img_rapper4")!, rapperNumber: 3), RapperModel(rapperName: "Bora", rapperImage: UIImage(named: "img_rapper5")!, rapperNumber: 4), RapperModel(rapperName: "Kerem", rapperImage: UIImage(named: "img_rapper6")!, rapperNumber: 5), RapperModel(rapperName: "Baki", rapperImage: UIImage(named: "img_rapper7")!, rapperNumber: 6), RapperModel(rapperName: "Eren", rapperImage: UIImage(named: "img_rapper8")!, rapperNumber: 7), RapperModel(rapperName: "Canturk", rapperImage: UIImage(named: "img_rapper9")!, rapperNumber: 8), RapperModel(rapperName: "Gizem", rapperImage: UIImage(named: "img_rapper10")!, rapperNumber: 9)]
    var rapSongURL: [String] = []
    var selectedRapper: Int = 0
    var selectedRapperUUID: String = ""
    var finalTitle: String = ""
    var finalSong: String = ""
    let GenerateVC = GeneratingSongVC()
    var currentSongBPM: Int = 0
    var backtrack: String = ""
    var lastCell = RapperCollectionViewCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.shared.getRappers()
        NotificationCenter.default.addObserver(self, selector: #selector(showRapperResult(data:)), name: NSNotification.Name(rawValue: "rapSongURL"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showRapURLResult(data:)), name: NSNotification.Name(rawValue: "finalRap"), object: nil)
        configureUI()
    }


    func configureUI() {

        view.backgroundColor = .systemBackground
        let cell = RapperCollectionViewCell()

        collectionView = NeonCollectionView<RapperModel, RapperCollectionViewCell>(
            objects: rapperArr,
            itemsPerRow: 2,
            leftPadding: 20,
            rightPadding: 20,
            horizontalItemSpacing: 5,
            verticalItemSpacing: 5
        )


        view.addSubview(rapLabel)
        rapLabel.text = "Rapper"
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

        for i in rapperArr {
            cell.configure(with: i)
        }

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).offset(-16)
            make.top.equalTo(rapLabel.snp.bottom).offset(32)
        }
        collectionView.objects = rapperArr

        collectionView.didSelect = { [self] object, indexPath in
            if let cell = collectionView.cellForItem(at: indexPath) as? RapperCollectionViewCell {
                lastCell.layer.borderWidth = 0
                lastCell = cell
                cell.layer.borderWidth = 5
                cell.layer.borderColor = UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1).cgColor
                cell.layer.cornerRadius = 10
            }
            selectedRapper = indexPath.row
            selectedRapperUUID = rapSongURL[indexPath.row]
            GenerateVC.rapperName = rapperArr[indexPath.row].rapperName
            nextButton.applyGradient(colours: [UIColor(red: 243 / 255, green: 92 / 255, blue: 112 / 255, alpha: 1), UIColor(red: 229 / 255.0, green: 65 / 255.0, blue: 87 / 255.0, alpha: 1.0), UIColor(red: 220 / 255.0, green: 45 / 255.0, blue: 150 / 255.0, alpha: 1.0)])
            GenerateVC.rapperNumber = indexPath.row
        }


    }

    @objc func continueButtonTapped() {
        player?.pause()
        GenerateVC.songBPM = currentSongBPM
        GenerateVC.songBacktrack = backtrack
        GenerateVC.rapName = finalTitle
        GenerateVC.wholeSong = finalSong
        FirestoreManager.setDocument(path: [
                .collection(name: "\(String(describing: Auth.auth().currentUser?.uid))"),
                .document(name: "\(UUID().uuidString)"),
        ], fields: [
            "title": finalTitle,
            "song": finalSong,
            "rapper": selectedRapper,
            "voicemodelUUID": selectedRapperUUID,
            "backing_track": backtrack,
            "bpm": currentSongBPM
        ])

        present(destinationVC: GenerateVC, slideDirection: .right)

    }
    @objc func backTapped() {
        self.dismiss(animated: true)
    }

    @objc func showRapperResult(data: Notification) {
        if let userinfo = data.userInfo {
            rapSongURL = userinfo["rapSongURL"] as! [String]
        }
    }
    @objc func showRapURLResult(data: Notification) {
        if let userinfo = data.userInfo {
            songs = userinfo["finalRap"] as! [String]
        }
    }


}



