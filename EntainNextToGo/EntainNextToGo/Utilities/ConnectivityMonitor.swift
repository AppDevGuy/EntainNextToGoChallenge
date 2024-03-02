//
//  ConnectivityMonitor.swift
//  EntainNextToGo
//
//  Created by Sean Smith on 2/3/2024.
//

import UIKit
import Network
import Combine

/// For purpose of unit testing.
protocol NetworkMonitoringInterface {
    func startMonitoring()
    func stopMonitoring()
    var isNetworkConnected: Bool { get }
}

/// Observe changes to the network.
@Observable final class ConnectivityMonitor: NetworkMonitoringInterface {

    // MARK: - Variables

    private var cancellables = Set<AnyCancellable>()
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "InternetConnectivityMonitor")
    private(set) var isNetworkConnected = true

    // MARK: - Lifecycle

    init() {
        monitor = NWPathMonitor()
        setupNotifications()
        startMonitoring()
    }

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            self.isNetworkConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }

}

// MARK: - Notifications

private extension ConnectivityMonitor {

    /// Handle user closing app and reopening the app.
    func setupNotifications() {
        NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)
            .sink { [weak self] _ in self?.stopMonitoring() }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
            .sink { [weak self] _ in self?.startMonitoring() }
            .store(in: &cancellables)
    }

}
