//
//  SpotifySessionManager.swift
//  Redde
//
//  Created by David Zubal on 1/5/19.
//  Copyright © 2019 David Zubal. All rights reserved.
//

import Foundation

private let sessionKey = "SpotifySession"

class SpotifySessionManager {

    static let shared = SpotifySessionManager()

    private init() { }

    private let spotifyClientID = "0c58d0fc6e4b4334b3887e9386faf6cd"
    private let spotifyRedirectURL = URL(string: "Redde://")!

    private lazy var configuration = SPTConfiguration(
        clientID: spotifyClientID,
        redirectURL: spotifyRedirectURL
    )

    private lazy var sessionManager: SPTSessionManager = {
        if let tokenSwapURL = URL(string: "https://redde-metronome.herokuapp.com/api/token"),
            let tokenRefreshURL = URL(string: "https://redde-metronome.herokuapp.com/api/refresh_token") {
            configuration.tokenSwapURL = tokenSwapURL
            configuration.tokenRefreshURL = tokenRefreshURL
            // If empty spotify will do an auto playback of last track
            configuration.playURI = ""
        }
        return SPTSessionManager(configuration: configuration, delegate: nil)
    }()

    func setup(with delegate: SPTSessionManagerDelegate?) {
        sessionManager.delegate = delegate
    }

    func authenticateWithSpotify() {
        let requestedScopes: SPTScope = [.appRemoteControl]
        sessionManager.initiateSession(with: requestedScopes, options: .default)
    }

    func renewSession() {
        restoreSession()
        sessionManager.renewSession()
    }

    func archiveSession(_ session: SPTSession) {
        do {
            let sessionData = try NSKeyedArchiver.archivedData(withRootObject: session, requiringSecureCoding: true)
            UserDefaults.standard.set(sessionData, forKey: sessionKey)
        } catch {
            print("Failed to archive session: \(error)")
        }
    }

    private func restoreSession() {
        guard let sessionData = UserDefaults.standard.data(forKey: sessionKey) else { return }
        do {
            let session = try NSKeyedUnarchiver.unarchivedObject(ofClass: SPTSession.self, from: sessionData)
            sessionManager.session = session
        } catch {
            print("error unarchiving session: \(error)")
        }
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) {
        sessionManager.application(app, open: url, options: options)
    }
}
