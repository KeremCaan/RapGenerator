//
//  APIManager.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 5.09.2023.
//

import UIKit

var tagCounter = 0

class APIManager {
    static var shared = APIManager()
    let vc = BeatsVC()
    var rapperSongs: [String] = []


    func makeGetRequest() {

        let headers = [
            "accept": "application/json",
            "authorization": "Basic cHViX2xjZ21zZ2tiY25paW1kdnB2Zjpwa18yMDhkOWU3MS04NjNjLTRmZTMtYmJkZS04ZmM2NTEwZDY4Y2M="
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.uberduck.ai/reference-audio/backing-tracks?detailed=true")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let httpResponse = response as! HTTPURLResponse

            if httpResponse.statusCode == 200 {


                do {
                    let decoder = JSONDecoder()
                    let messages = try decoder.decode(Beats.self, from: data)
                    DispatchQueue.main.async { [self] in
                        for i in messages.backingTracks ?? [] {
                            beatURL.append(i.url)
                            songPaths.append(i.uuid)
                            songBPM.append(i.bpm)
                            songNamesArr.append(String(i.name))
                            print(songNamesArr)
                            vc.collectionView.objects = songNamesArr
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                            for i in songNamesArr {
                                BeatsCollectionViewCell().configure(with: i)
                            }
                        })

                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "beatNames"), object: nil, userInfo: ["beat": songNamesArr])
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "beatUUID"), object: nil, userInfo: ["uuid": songPaths])
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "beatURL"), object: nil, userInfo: ["url": beatURL])
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "beatBPM"), object: nil, userInfo: ["bpm": songBPM])
                    }

                } catch DecodingError.dataCorrupted(let context) {
                    print(context)
                } catch DecodingError.keyNotFound(let key, let context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch DecodingError.valueNotFound(let value, let context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch DecodingError.typeMismatch(let type, let context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }




            }

        }

        task.resume()
    }

    func getRappers() {

        let rapVC = RapperVC()
        let headers = [
            "accept": "application/json",
            "authorization": "Basic cHViX2xjZ21zZ2tiY25paW1kdnB2Zjpwa18yMDhkOWU3MS04NjNjLTRmZTMtYmJkZS04ZmM2NTEwZDY4Y2M="
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.uberduck.ai/voices?mode=tts-basic&slim=false")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                if httpResponse!.statusCode == 200 {


                    let jsonData = try? JSONDecoder().decode(RapSongs.self, from: data!)
                    DispatchQueue.main.async {
                        for i in jsonData! {
                            rapVC.rapSongURL.append(i.voicemodelUUID)
                        }
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "rapSongURL"), object: nil, userInfo: ["rapSongURL": rapVC.rapSongURL])
                        for song in rapVC.rapSongURL {
                            self.getSongURL(url: song)
                        }

                    }




                }
            }
        })

        dataTask.resume()
    }

    func getSongURL(url: String) {


        let headers = ["accept": "application/json"]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.uberduck.ai/voices/\(url)/samples")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                if httpResponse!.statusCode == 200 {


                    let jsonData = try? JSONDecoder().decode(Rapper.self, from: data!)
                    DispatchQueue.main.async { [self] in
                        for i in jsonData! {
                            if i.url != "" {
                                rapperSongs.append(i.url)
                            }

                        }
                        print(rapperSongs)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "finalRap"), object: nil, userInfo: ["finalRap": rapperSongs])
                    }

                }
            }
        })

        dataTask.resume()
    }

    @objc func getSong(bpm: Int, backing_track: String, songLyrics: String) {


        let arraySong = songLyrics.components(separatedBy: CharacterSet.newlines)
        print(arraySong)
        let headers = [
            "accept": "application/json",
            "content-type": "application/json",
            "authorization": "Basic cHViX2xjZ21zZ2tiY25paW1kdnB2Zjpwa18yMDhkOWU3MS04NjNjLTRmZTMtYmJkZS04ZmM2NTEwZDY4Y2M="
        ]
        let parameters = [
            "bpm": bpm,
            "voice": "zwf",
            "format": "json",
            "backing_track": backing_track,
            "lyrics": [arraySong]
        ] as [String: Any]

        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.uberduck.ai/tts/freestyle")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData! as Data

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse?.statusCode)
                if httpResponse!.statusCode == 200 {


                    let jsonData = try? JSONDecoder().decode(BeatURL.self, from: data!)
                    DispatchQueue.main.async {
                        print(jsonData?.mixURL)
                        SongVC().loadRadio(radioURL: jsonData!.mixURL)
                    }

                }
            }


        })

        dataTask.resume()
    }



}
