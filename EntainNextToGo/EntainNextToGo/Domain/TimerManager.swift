//
//  TimerManager.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 28/2/2024.
//

import UIKit
import Combine

/// This class serves as the App Manager responsible for triggering view updates and data fetch events.
///
/// We can have multiple instances of this class to manage:
/// - Display Updates every second
/// - Automatic Data fetch events every N seconds.
///
/// To use this class effectively:
///
/// ```
///  // Fire the timer every 1 second.
/// timerManager = TimerManager(interval: 1)
///
/// timerManager?.start()
///    .sink(receiveValue: { currentDate in
///        print("Timer fired at: \(currentDate)")
///    })
///    .store(in: &cancellables)
/// ```
final public class TimerManager {

    // MARK: - Variables
    
    /// The proivate timer that governs the triggering of events.
    private var timer: Timer?
    /// The interval which the timer should fire.
    private var interval: TimeInterval
    /// Using combine, we want to enable observations of the timer fire events.
    private let subject = PassthroughSubject<Date, Never>()
    /// Store the publishers.
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle

    /// The specified interval which the timer should fire.
    public init(interval: TimeInterval) {
        self.interval = interval
        setupNotifications()
    }

    deinit {
        // Handle app closing.
        timer?.invalidate()
        cancellables.forEach { $0.cancel() }
    }

}

// MARK: - Private Functions

fileprivate extension TimerManager {

    func startTimer() {
        // Invalidate any existing timer
        timer?.invalidate()
        // Schedule based on the interval
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            // Publish the current date
            self?.subject.send(Date())
        }
    }

    /// Handle user closing app and reopening the app.
    func setupNotifications() {
        NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)
            .sink { [weak self] _ in self?.timer?.invalidate() }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
            .sink { [weak self] _ in self?.startTimer() }
            .store(in: &cancellables)
    }

}

// MARK: - Public Functions

public extension TimerManager {

    /// Using the start funtction, you can subscribe to the timer fire events.
    ///
    /// The publisher will return a date object, which is set to the current date.
    func start() -> AnyPublisher<Date, Never> {
        startTimer()
        return subject.eraseToAnyPublisher()
    }

}
