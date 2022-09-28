//
//  PlaySongViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 25.09.2022.
//

import AVFoundation
import UIKit
/// Экран с проигрывателем песни
final class PlaySongViewController: UIViewController {
    
    // MARK: - Public properties
    
    var song: Song?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var songCoverImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    
    // MARK: - Private properties
    
    private lazy var player = AVAudioPlayer()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateTimeSlider()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    // MARK: - IBAction
    
    @IBAction func timeSliderAction(_ sender: UISlider) {
        player.stop()
        player.currentTime = TimeInterval(timeSlider.value)
        player.prepareToPlay()
        player.play()
    }
    
    @IBAction func playButtonAction(_ sender: UIButton) {
        setupPlayer()
    }
    
    @IBAction func pauseButtonAction(_ sender: UIButton) {
        guard player.isPlaying else { player.play()
            return
        }
        player.pause()
    }
    
    @IBAction func restartButtonAction(_ sender: UIButton) {
        guard player.isPlaying else { player.play()
            return
        }
        timeSlider.value = 0
        player.currentTime = 0
        player.play()
    }
    
    @IBAction func volumeSliderAction(_ sender: UISlider) {
        player.volume = volumeSlider.value
    }
    
    @IBAction func dissmissButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func shareButtonAction(_ sender: UIButton) {
        let activity = UIActivityViewController(
            activityItems: [song?.fullName ?? "nil"],
            applicationActivities: .none)
        present(activity, animated: true, completion: .none)
    }
    
    // MARK: - Actions
    
    @objc private func updateSlider(_ target: UISlider) {
        timeSlider.value = Float(player.currentTime)
    }
}

// MARK: - Setup

private extension PlaySongViewController {
    
    func setupUI() {
        setSong()
        setupShadowView()
    }
    
    func setSong() {
        guard let song = song else { return }
        songCoverImageView.image = UIImage(named: song.image)
        songNameLabel.text = song.name
        artistNameLabel.text = song.artist
    }
    
    func setupShadowView() {
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.3)
        shadowView.backgroundColor = .white
        shadowView.layer.cornerRadius = 8
    }
    
    func setupPlayer() {
        if player.isPlaying {
            playButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            player.stop()
        } else {
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            guard let audioPath = Bundle.main.path(
                forResource: song?.fullName,
                ofType: "mp3"
            ) else { return }
            
            do {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                timeSlider.maximumValue = Float(player.duration)
                player.play()
            } catch {
                print("Error")
            }
        }
    }
    
    func updateTimeSlider() {
        _ = Timer.scheduledTimer(timeInterval: 0.1,
                                 target: self,
                                 selector: #selector(updateSlider(_:)),
                                 userInfo: nil,
                                 repeats: true)
    }
}
