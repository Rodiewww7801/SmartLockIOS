//
//  ApplicationCoordinator.swift
//  FaceDetectionIOS
//
//  Created by Rodion Hladchenko on 01.04.2023.
//

import Foundation

final class ApplicationCoordinator: Coordinator {
    let router: Router
    private var isUserLoggedIn = false
    
    init(router: Router) {
        self.router = router
    }
    
    override func start() {
        if isUserLoggedIn {
            mainListScene()
        } else {
            authenticationScene()
        }
    }
    
    private func authenticationScene() {
        let authenticationCoordinator = AuthenticationSceneCoordinator(router: router)
        authenticationCoordinator.showMainView = { [weak self] in
            self?.removeChild(authenticationCoordinator)
            authenticationCoordinator.removeAllChildren()
            self?.mainListScene()
        }
        self.childCoordinators.append(authenticationCoordinator)
        authenticationCoordinator.start()
    }
    
    private func mainListScene() {
        let mainListCoordinator = MainListSceneCoordinator(router: router)
        self.childCoordinators.append(mainListCoordinator)
        mainListCoordinator.start()
    }
}
