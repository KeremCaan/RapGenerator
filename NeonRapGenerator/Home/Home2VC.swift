//
//  Home2VC.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 29.08.2023.
//

import UIKit
import NeonSDK
import Firebase
import FirebaseAuth

class Home2VC: UIViewController {
    let settingsButton: UIButton = UIButton()
    let rapLabel: UILabel = UILabel()
    let addButton: UIButton = UIButton()
    let songsLabel: UILabel = UILabel()
    var userInfoArr: [SavedRaps] = []
    var rapper: Int = 0
    var backing_Track: String = ""
    var songLyrics: String = ""
    var songTitle: String = ""
    var uid: [String] = []
    let playerVC = SongVC()



    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }


    func configureUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(rapLabel)
        rapLabel.text = "Rap Gene"
        rapLabel.font = UIFont(name: "Poppins-Bold", size: 21)
        rapLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }

        view.addSubview(songsLabel)
        songsLabel.text = "Songs"
        songsLabel.font = UIFont(name: "Poppins", size: 18)
        songsLabel.snp.makeConstraints { make in
            make.top.equalTo(rapLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(32)
        }

        let collectionView = NeonCollectionView<SavedRaps, CollectionViewCell>(
            objects: userInfoArr,
            itemsPerRow: 2,
            leftPadding: 20,
            rightPadding: 20,
            horizontalItemSpacing: 10,
            verticalItemSpacing: 10
        )
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(songsLabel.snp.bottom).offset(16)
        }


        collectionView.didSelect = { [self] object, indexPath in
            playerVC.bpm = object.bpm
            playerVC.songLyrics = object.song
            playerVC.backing_track = object.backingtrack
            playerVC.rapperNumber = object.rapper
            playerVC.songTitle = object.title
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                self.present(destinationVC: self.playerVC, slideDirection: .right)
            })




        }


        collectionView.contextMenuActions = [
            ContextMenuAction<SavedRaps>(title: "Share") { [self] app, indexPath in
                let activityController = UIActivityViewController(activityItems: ["\(userInfoArr[indexPath.row].title)"], applicationActivities: nil)
                present(activityController, animated: true)
            },
            ContextMenuAction<SavedRaps>(title: "Rename") { app, indexPath in
                let alert = UIAlertController(title: "Rename \(self.userInfoArr[indexPath.row].title)", message: "Type the new name for your song below.", preferredStyle: .alert)
                alert.addTextField { field in
                    field.placeholder = "New name for the song."
                    field.returnKeyType = .next
                }
                alert.addAction(UIAlertAction(title: "Rename", style: .default, handler: { _ in
                    guard let fields = alert.textFields else { return }
                    let myField = fields[0]
                    guard let newName = myField.text else { return }
                    FirestoreManager.updateDocument(path: [
                            .collection(name: "\(Auth.auth().currentUser?.uid)"),
                            .document(name: "\(self.uid[indexPath.row])")
                    ], fields: [
                        "title": newName
                    ])
                    self.userInfoArr[indexPath.row].title = newName
                    collectionView.objects = self.userInfoArr
                }))
                self.present(alert, animated: true)
            },
            ContextMenuAction<SavedRaps>(title: "Delete", imageSystemName: "trash", isDestructive: true) { [self] app, indexPath in
                let alert = UIAlertController(title: "Delete \(userInfoArr[indexPath.row].title)", message: "Are you sure you want to delete this song? This action can't be undone.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: { [self] in
                        userInfoArr.remove(at: indexPath.row)
                        collectionView.objects = userInfoArr
                        FirestoreManager.deleteDocument(path: [
                                .collection(name: "\(Auth.auth().currentUser?.uid)"),
                                .document(name: "\(uid[indexPath.row])")
                        ])
                    })
                }))
                present(alert, animated: true)
            }
        ]


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
            make.bottom.equalToSuperview().offset(-80)
            make.width.height.equalTo(72)
        }
    }


    @objc func settingsTapped() {
        present(destinationVC: SettingsVC(), slideDirection: .right)
    }

    @objc func addButtonTapped() {
        if userInfoArr.count >= 3 && Neon.isUserPremium == false {
            present(destinationVC: PaywallVC(), slideDirection: .right)
        } else {
            present(destinationVC: AddSongVC(), slideDirection: .right)
        }

    }

}

