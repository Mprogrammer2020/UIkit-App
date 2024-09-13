//
//  AppDelegate.swift
//  Hey Greek
//
//  Created by netset on 30/11/19.
//  Copyright © 2019 netset. All rights reserved.


import UIKit
import StompClientLib

var isCheckSocketConnect = Bool()

protocol DeledateSocketChat {
    func handleSocketResponse(_ dict: NSDictionary)
}

var deledateSocketChat:DeledateSocketChat?

class SocketIOManager: NSObject, StompClientLibDelegate {
    
    //MARK:- Variables
    static let sharedInstance = SocketIOManager()
    var socketServerUrl = URL(string: ServerLink.webSocketUrl)!
    var header = [String:String]()
    var socketClient = StompClientLib()
    var isSendChatSubcribe = Bool()
    var isReceiveChatSubcribe = Bool()
    var messageJsonType = String()
    var socketMessage = String()
    var socketStatusCode = Int()
    
    //MARK:- Connect To Server Method
    func connectToServer() {
        let token = accessTokenSaved
        if token != "" && !isCheckSocketConnect {
            let headers: [String: String] = [
                "deviceId" : Constants.AppInfo.DeviceId,
                "appVersion" : Constants.AppInfo.appVersion,
                "deviceType" : "i",
                "Content-Type" : "application/json",
                "Authorization" : "Bearer \(token)",
                "deviceToken" : deviceTokenSaved
            ]
            debugPrint("socket headers", headers)
            debugPrint("socket url", socketServerUrl)
            
            var urlRequest = URLRequest(url: socketServerUrl)
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
            socketClient.openSocketWithURLRequest(request: urlRequest as NSURLRequest, delegate: self)
        }
    }
    
    func reconnectServer() {
        DispatchQueue.main.async {
            self.socketClient.reconnect(request: NSURLRequest(url: self.socketServerUrl), delegate: self, connectionHeaders: self.header)
        }
    }
    
    func sendMessageToAnotherUser(urlStr: String,messageStr: String) {
        debugPrint("Url Str:- ",urlStr)
        debugPrint("Message Str:- ",messageStr)
        socketClient.sendMessage(message: messageStr, toDestination: urlStr, withHeaders: [:], withReceipt: "")
    }
    
    func sendMessageToAnotherUserWithText(urlStr: String, jsonData: AnyObject) {
        debugPrint("Url Str:- ",urlStr)
        debugPrint("Json Data:- ",jsonData)
        socketClient.sendJSONForDict(dict: jsonData, toDestination: urlStr)
    }
    
    func receiveAllMessage(urlStr: String) {
        debugPrint("Url Str:- ",urlStr)
        socketClient.sendMessage(message: "", toDestination: urlStr, withHeaders: [:], withReceipt: "")
    }

    func subscribeChatRoom(urlStr: String) {
        debugPrint("Url Str:- ",urlStr)
        socketClient.unsubscribe(destination: urlStr)
        socketClient.subscribe(destination: urlStr)
    }
   
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        socketClient.connection = false
        debugPrint("Hello")
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        socketClient.connection = false
//        reconnectServer()
        isCheckSocketConnect = false
        debugPrint("Socket Error:- ",message ?? "")
    }
    
    func serverDidSendPing() {
        debugPrint("Hello")
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        socketClient.connection = true
        isCheckSocketConnect = true
        debugPrint("Socket is connected")
        self.subscribeChatRoom(urlStr: "/topic/greetings")
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        socketClient.connection = false
        debugPrint("Socket is Disconnected")
//        reconnectServer()
        isCheckSocketConnect = false
    }
    
    func checkSocketStatus () {
        let socketConnectionStatus = socketClient.isConnected()
        debugPrint("SocketConnectionStatus:- ",socketConnectionStatus)
    }
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        debugPrint("JSON Body :-",stringBody ?? "")
        if let dataDetail = jsonBody as? NSDictionary {
//            debugPrint("dataDetail:",dataDetail)
            deledateSocketChat?.handleSocketResponse(dataDetail)

        }
    }
}

extension String {
    
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

