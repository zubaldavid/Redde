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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.


        let spotifyButton = UIButton()
        spotifyButton.constrain(.height, .width, toConstant: 200)
        spotifyButton.backgroundColor = UIColor.blue
        spotifyButton.setTitle("Sign In To Spotify", for: .normal)

        let signIn = UILabel()

        view.addSubview(spotifyButton)

    }


}

