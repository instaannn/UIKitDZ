//
//  TimerViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 21.09.2022.
//

import UIKit

/// Экран таймера
final class TimerViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let startTimeKey = "startTime"
        static let stopTimeKey = "stopTime"
        static let countingKey = "countingKey"
        static let startButtonTitle = "Start"
        static let stopButtonTitle = "Stop"
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var startStopButton: UIButton!
    @IBOutlet private weak var resetButton: UIButton!
    
    // MARK: - Private properties
    
    private var timerCounting = false
    private var startTime: Date?
    private var stopTime: Date?
    private var scheduledTimer: Timer?
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        getUserDefaultsValue()
        startCountingTimer()
    }
    
    // MARK: - IBAction
    
    @IBAction private func startStopButtonAction(_ sender: UIButton) {
        if timerCounting {
            setStopTime(date: Date())
            stopTimer()
        } else {
            if let stop = stopTime {
                let restartTime = calculateRestartTime(start: startTime ?? Date(), stop: stop)
                setStopTime(date: nil)
                setStartTime(date: restartTime)
            } else {
                setStartTime(date: Date())
            }
            startTimer()
        }
    }
    
    @IBAction private func resetButtonAction(_ sender: UIButton) {
        setStopTime(date: nil)
        setStartTime(date: nil)
        timeLabel.text = makeTimeString(hour: 0, min: 0, sec: 0)
        stopTimer()
    }
    
    // MARK: - Private methods
    
    private func setStartTime(date: Date?) {
        startTime = date
        userDefaults.set(startTime, forKey: Constants.startTimeKey)
    }
    
    private func setStopTime(date: Date?) {
        stopTime = date
        userDefaults.set(stopTime, forKey: Constants.stopTimeKey)
    }
    
    private func setTimeCounting(value: Bool) {
        timerCounting = value
        userDefaults.set(timerCounting, forKey: Constants.countingKey)
    }
    
    private func getUserDefaultsValue() {
        startTime = userDefaults.object(forKey: Constants.startTimeKey) as? Date
        stopTime = userDefaults.object(forKey: Constants.stopTimeKey) as? Date
        timerCounting = userDefaults.bool(forKey: Constants.countingKey)
    }
    
    private func startCountingTimer() {
        if timerCounting {
            startTimer()
        } else {
            stopTimer()
            guard let start = startTime,
                  let stop = stopTime else { return }
            let time = calculateRestartTime(start: start, stop: stop)
            let diff = Date().timeIntervalSince(time)
            setTimeLabel(Int(diff))
        }
    }
    
    private func stopTimer() {
        scheduledTimer?.invalidate()
        setTimeCounting(value: false)
        startStopButton.setTitle(Constants.startButtonTitle, for: .normal)
        startStopButton.setTitleColor(.systemGreen, for: .normal)
    }
    
    private func startTimer() {
        scheduledTimer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(refreshValueAction),
            userInfo: nil,
            repeats: true
        )
        setTimeCounting(value: true)
        startStopButton.setTitle(Constants.stopButtonTitle, for: .normal)
        startStopButton.setTitleColor(.systemRed, for: .normal)
    }
    
    private func setTimeLabel(_ value: Int) {
        let time = secondsToHoursMinutesSeconds(ms: value)
        let timeString = makeTimeString(hour: time.0, min: time.1, sec: time.2)
        timeLabel.text = timeString
    }
    
    private func secondsToHoursMinutesSeconds(ms: Int) -> (Int, Int, Int) {
        let hour = ms / 3600
        let min = (ms % 3600) / 60
        let sec = (ms % 3600) % 60
        return (hour, min, sec)
    }
    
    private func makeTimeString(hour: Int, min: Int, sec: Int) -> String {
        "\(String(format: "%02d", hour)):\(String(format: "%02d", min)):\(String(format: "%02d", sec))"
    }
    
    private func calculateRestartTime(start: Date, stop: Date) -> Date {
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }
    
    @objc private func refreshValueAction() {
        guard let start = startTime else {
            stopTimer()
            setTimeLabel(0)
            return
        }
        let diff = Date().timeIntervalSince(start)
        setTimeLabel(Int(diff))
        
    }
}
