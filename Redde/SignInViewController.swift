//
//  ViewController.swift
//  Redde
//
//  Created by David Zubal on 12/15/18.
//  Copyright © 2018 David Zubal. All rights reserved.
//

import UIKit
import AnchorKit

class SignInViewController: UIViewController {
    private lazy var spotifyButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 35
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage.imageFromColor(UIColor.spotify), for: .normal)
        button.setBackgroundImage(UIImage.imageFromColor(UIColor.white), for: .highlighted)
        button.setTitle("Spotfy Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.spotify, for: .highlighted)
        button.addTarget(self, action: #selector(spotifyButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(spotifyButton)
        spotifyButton.constrainCenter(to: view)
        spotifyButton.constrain(to: CGSize(width: 250, height: 75))
    }

    @objc private func spotifyButtonTapped() {
        SpotifySessionManager.shared.authenticateWithSpotify()
    }

    func displayErrorMessage(error: Error) {
        // When changing the UI, all actions must be done on the main thread,
        // since this can be called from a notification which doesn't run on
        // the main thread, we must add this code to the main thread's queue

        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error",
                                                    message: error.localizedDescription,
                                                    preferredStyle: .alert)

            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)

            self.present(alertController, animated: true, completion: nil)
        }
    }

    func successfulLogin() {

    }
}

/**
 VC Life Cycle:

 - initializer (init)
 - loadView() gets called (normally no need to override)
 - viewDidLoad() -> always call 'super' and add subviews here and constraints
 */

