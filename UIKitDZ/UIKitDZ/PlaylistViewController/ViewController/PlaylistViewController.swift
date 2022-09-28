//
//  PlaylistViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 21.09.2022.
//

import UIKit
/// Экран плейлист
final class PlaylistViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var firstSongButton: UIButton!
    @IBOutlet weak var secondSongButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction
    
    @IBAction func firstSongButtonAction(_ sender: UIButton) {
        goToPlaySongViewController(
            song: Song(
                name: "Бриллианты",
                time: "3:25",
                image: "thomas",
                artist: "Thomas Mraz",
                fullName: "Thomas Mraz - Бриллианты"
            )
        )
    }
    
    @IBAction func secondSongButtonAction(_ sender: UIButton) {
        goToPlaySongViewController(
            song: Song(
                name: "Розовый фламинго",
                time: "3:43",
                image: "crem soda",
                artist: "CREAM SODA, Алена Свиридова",
                fullName: "CREAM SODA, Алена Свиридова - Розовый фламинго")
        )
    }
    
    // MARK: - Private methods
    
    private func goToPlaySongViewController(song: Song) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let playSongViewController = storyboard.instantiateViewController(
            withIdentifier: "PlaySongViewController"
        ) as? PlaySongViewController else { return }
        playSongViewController.song = Song(
            name: song.name,
            time: song.time,
            image: song.image,
            artist: song.artist,
            fullName: song.fullName
        )
        playSongViewController.modalPresentationStyle = .formSheet
        present(playSongViewController, animated: true)
    }
}
