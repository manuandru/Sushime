//
//  WrapperMQTT.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 24/06/22.
//

import Foundation
import CocoaMQTT
import SwiftUI

class WrapperMQTT: CocoaMQTT5Delegate, ObservableObject {

    var clientMQTT: CocoaMQTT5
    
    @Published var creationState = CreationState()
    
    var tableToConnect: String?

    init() {
        creationState = CreationState()
        let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
        self.clientMQTT = CocoaMQTT5(clientID: clientID, host: "4.tcp.eu.ngrok.io", port: 11221)
        self.clientMQTT.delegate = self
        
        _ = self.clientMQTT.connect()
    }
    
    deinit {
        clientMQTT.disconnect()
        print("sconnesso")
    }

    func subscribeTo(table: String) {
        creationState = CreationState()
        tableToConnect = "\(table)/#"
    }

    func unsubscribeFrom(table: String) {
        tableToConnect = .none
    }
    
    
    
    func mqtt5(_ mqtt5: CocoaMQTT5, didReceiveMessage message: CocoaMQTT5Message, id: UInt16, publishData: MqttDecodePublish?) {
        let topics = message.topic.split(separator: "/")

        if topics.count == 2 {
            let command = topics[1]
            switch command {
            case "newUser": handleNewUserJoin(user: message.string)
                break
            case "quitUser": handleUserQuit(user: message.string)
                break
            case "menu": print("menu")
                break
            default:
                print("Not Handled: \(command)")
            }
        }
    }

    private func handleNewUserJoin(user: String?) {
        if let user = user {
            withAnimation {
                creationState.users.append(user)
            }
        }
    }
    
    private func handleUserQuit(user: String?) {
        if let user = user {
            let indexToRemove = creationState.users.firstIndex(of: user)
            if let indexToRemove = indexToRemove {
                withAnimation {
                    _ = creationState.users.remove(at: indexToRemove)
                }
            }
        }
    }


    func mqtt5(_ mqtt5: CocoaMQTT5, didConnectAck ack: CocoaMQTTCONNACKReasonCode, connAckData: MqttDecodeConnAck?) {
        if let tableToConnect = tableToConnect, clientMQTT.connState == .connected {
            clientMQTT.subscribe(tableToConnect)
        }
    }

    func mqtt5(_ mqtt5: CocoaMQTT5, didPublishMessage message: CocoaMQTT5Message, id: UInt16) {

    }

    func mqtt5(_ mqtt5: CocoaMQTT5, didPublishAck id: UInt16, pubAckData: MqttDecodePubAck?) {

    }

    func mqtt5(_ mqtt5: CocoaMQTT5, didPublishRec id: UInt16, pubRecData: MqttDecodePubRec?) {

    }

    func mqtt5(_ mqtt5: CocoaMQTT5, didSubscribeTopics success: NSDictionary, failed: [String], subAckData: MqttDecodeSubAck?) {

    }

    func mqtt5(_ mqtt5: CocoaMQTT5, didUnsubscribeTopics topics: [String], UnsubAckData: MqttDecodeUnsubAck?) {

    }

    func mqtt5(_ mqtt5: CocoaMQTT5, didReceiveDisconnectReasonCode reasonCode: CocoaMQTTDISCONNECTReasonCode) {

    }

    func mqtt5(_ mqtt5: CocoaMQTT5, didReceiveAuthReasonCode reasonCode: CocoaMQTTAUTHReasonCode) {

    }

    func mqtt5DidPing(_ mqtt5: CocoaMQTT5) {

    }

    func mqtt5DidReceivePong(_ mqtt5: CocoaMQTT5) {

    }

    func mqtt5DidDisconnect(_ mqtt5: CocoaMQTT5, withError err: Error?) {

    }
}

//extension AppPath: CocoaMQTT5Delegate {
//
//
//    func mqtt5(_ mqtt5: CocoaMQTT5, didReceiveMessage message: CocoaMQTT5Message, id: UInt16, publishData: MqttDecodePublish?) {
//        let topics = message.topic.split(separator: "/")
//
//        if topics.count == 2 {
//            let command = topics[1]
//            switch command {
//            case "newUser": handleNewUserJoin(user: message.string)
//                break
//            case "menu": print("menu")
//                break
//            default:
//                print("Not Handled: \(command)")
//            }
//        }
//    }
//
//    private func handleNewUserJoin(user: String?) {
//        if let user = user {
//            DispatchQueue.main.async {
//                self.objectWillChange.send()
//                self.creationState.users.append(user)
//            }
//        }
//    }
//
//
//    func mqtt5(_ mqtt5: CocoaMQTT5, didConnectAck ack: CocoaMQTTCONNACKReasonCode, connAckData: MqttDecodeConnAck?) {
//
//    }
//
//    func mqtt5(_ mqtt5: CocoaMQTT5, didPublishMessage message: CocoaMQTT5Message, id: UInt16) {
//
//    }
//
//    func mqtt5(_ mqtt5: CocoaMQTT5, didPublishAck id: UInt16, pubAckData: MqttDecodePubAck?) {
//
//    }
//
//    func mqtt5(_ mqtt5: CocoaMQTT5, didPublishRec id: UInt16, pubRecData: MqttDecodePubRec?) {
//
//    }
//
//    func mqtt5(_ mqtt5: CocoaMQTT5, didSubscribeTopics success: NSDictionary, failed: [String], subAckData: MqttDecodeSubAck?) {
//
//    }
//
//    func mqtt5(_ mqtt5: CocoaMQTT5, didUnsubscribeTopics topics: [String], UnsubAckData: MqttDecodeUnsubAck?) {
//
//    }
//
//    func mqtt5(_ mqtt5: CocoaMQTT5, didReceiveDisconnectReasonCode reasonCode: CocoaMQTTDISCONNECTReasonCode) {
//
//    }
//
//    func mqtt5(_ mqtt5: CocoaMQTT5, didReceiveAuthReasonCode reasonCode: CocoaMQTTAUTHReasonCode) {
//
//    }
//
//    func mqtt5DidPing(_ mqtt5: CocoaMQTT5) {
//
//    }
//
//    func mqtt5DidReceivePong(_ mqtt5: CocoaMQTT5) {
//
//    }
//
//    func mqtt5DidDisconnect(_ mqtt5: CocoaMQTT5, withError err: Error?) {
//
//    }
//}
