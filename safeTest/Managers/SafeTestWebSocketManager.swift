//
//  SafeTestWebSocketManager.swift
//  safeTest
//
//  Created by Csongor Nagy on 22/5/2024.
//

import Foundation
import UIKit

@objc protocol SafeTestWebSocketManagerDelegate: NSObjectProtocol {
    @objc optional func didConnectSocket()
    @objc optional func didDisconnectSocket()
    @objc optional func didReceivedMesssage(message: String)
    @objc optional func didReceivedData(data: Data)
}

class SafeTestWebSocketManager: NSObject, URLSessionWebSocketDelegate {
    
    private var urlSession: URLSession?
    private var webSocket: URLSessionWebSocketTask?
    weak var managerDelegate: SafeTestWebSocketManagerDelegate?
    
    override init() {
        
        super.init()
        
        urlSession = URLSession(configuration: .default,
                                delegate: self,
                                delegateQueue: OperationQueue.main)
        
        let socketUrl = URL(string: "wss://free.blr2.piesocket.com/v3/1?api_key=A6smxWt7ROL3xksSjwoGtrwfbwmFnG8pagM7ppju&notify_self=1")
        webSocket = urlSession?.webSocketTask(with: socketUrl!)
        webSocket?.resume()
        
        webSocket?.receive(completionHandler: { [weak self] result in
            switch result {
            case .success(let socketMessage):
                switch socketMessage {
                case .string(let message):
                    self!.managerDelegate?.didReceivedMesssage?(message: message)
                case .data(let data):
                    self!.managerDelegate?.didReceivedData?(data: data)
                @unknown default:
                    break
                }
            case .failure(_):
                print("Error")
            }
        })
    }
    
    func pingSocket() {
        webSocket?.sendPing(pongReceiveHandler: { [self] error in
            if (error != nil) {
                webSocket?.resume()
            }
        })
    }
    
    func closeSocket() {
        webSocket?.cancel(with: .goingAway, reason: "Session ended".data(using: .utf8))
    }
    

    // MARK: URLSessionWebSocketDelegate Methods
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        managerDelegate?.didConnectSocket?()
        pingSocket()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        managerDelegate?.didDisconnectSocket?()
    }
}
