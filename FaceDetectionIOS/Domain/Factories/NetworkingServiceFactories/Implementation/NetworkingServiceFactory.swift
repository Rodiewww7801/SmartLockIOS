//
//  NetworkingServiceFactory.swift
//  FaceDetectionIOS
//
//  Created by Rodion Hladchenko on 14.08.2023.
//

import Foundation

struct NetworkingServiceFactory: NetworkingServiceFactoryProtocol {
    private static var sessionManagerShared: SessionManagerProtocol?
    private static var networkingServiceShared: NetworkingServiceProotocol?
    private static var tokenManagerShared: TokenManagerProtocol?
    
    static func sessionManager() -> SessionManagerProtocol {
        if let sessionManagerShared = self.sessionManagerShared {
            return sessionManagerShared
        }
        let sessionManager = SessionManager()
        self.sessionManagerShared = sessionManager
        return sessionManager
    }
    
    static func networkingService() -> NetworkingServiceProotocol {
        if let networkingService = self.networkingServiceShared {
            return networkingService
        }
        let networkingService = NetworkingService(sessionManager: sessionManager(), tokenManager: tokenManager())
        self.networkingServiceShared = networkingService
        return networkingService
    }
    
    static func tokenManager() -> TokenManagerProtocol {
        if let tokenManagerShared = self.tokenManagerShared {
            return tokenManagerShared
        }
        let tokenManager = TokenManager(sessionManager: sessionManager())
        self.tokenManagerShared = tokenManager
        return tokenManager
    }
    
    static func tokenObservable() -> TokenObservable {
        return tokenManager() as! TokenObservable
    }
}
