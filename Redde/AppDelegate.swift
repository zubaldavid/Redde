//
//  AppDelegate.swift
//  Redde
//
//  Created by David Zubal on 12/15/18.
//  Copyright © 2018 David Zubal. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions  launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        SpotifySessionManager.shared.setup(with: self)
        SpotifySessionManager.shared.renewSession()

        window = UIWindow(frame: UIScreen.main.bounds)

//        let firstVC = UINavigationController(rootViewController: SignInViewController())

        let signInViewController = SignInViewController()
        //homeViewController.view.backgroundColor = UIColor.red
        window!.rootViewController = signInViewController
        window!.makeKeyAndVisible()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        SpotifySessionManager.shared.application(app, open: url, options: options)
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Redde")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate: SPTSessionManagerDelegate {
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        DispatchQueue.main.async {
            print("Access token: \(session.accessToken), expires at \(session.expirationDate)")
            SpotifySessionManager.shared.archiveSession(session)
            self.openMenuViewController()
        }
    }

    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        DispatchQueue.main.async {
            // present login screen
            print("fail", error)
        }
    }

    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        DispatchQueue.main.async {
            print("renewed", session)
            self.openMenuViewController()
        }
    }

    func openMenuViewController() {
        self.window?.rootViewController = MenuViewController()
    }
        /**
         Upon launching the app:

         Attempt to first renew the session:
         -
         - call renewSession() in SpotifySessionManager

         If it fails, (in this method), then the user is logged out. At that point,
         you can present your login screen.

         If it succeeds, then save the access token to the keychain and take the user
         straight to the MenuViewController.


        */
}
