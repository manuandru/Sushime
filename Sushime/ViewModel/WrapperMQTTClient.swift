//
//  WrapperMQTTClient.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 25/06/22.
//

import Foundation
import CocoaMQTT
import SwiftUI

class WrapperMQTTClient: CocoaMQTT5Delegate, ObservableObject {

    var clientMQTT: CocoaMQTT5
    
    @Published var status: CocoaMQTTConnState
    
//    @Published var creationState = CreationState()
    
//    var finalMenu = FinalMenuForMaster()
    
    @Published var bol = false
    
    
    var tableToConnect: String?

    init() {
//        creationState = CreationState()
        let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
        self.clientMQTT = CocoaMQTT5(clientID: clientID, host: "4.tcp.eu.ngrok.io", port: 11221)
        status = self.clientMQTT.connState
        self.clientMQTT.delegate = self

        clientMQTT.autoReconnect = true
        clientMQTT.autoReconnectTimeInterval = 1
        
        
        _ = clientMQTT.connect()
    }
    
    deinit {
        clientMQTT.disconnect()
    }

    func subscribeTo(table: String) {
//        creationState = CreationState()
        tableToConnect = "\(table)/#"
    }

    func unsubscribeFrom(table: String) {
        if let tableToConnect = tableToConnect, clientMQTT.connState == .connected {
            clientMQTT.unsubscribe(tableToConnect)
        }
        tableToConnect = .none
    }
    
    // [idcibo:quantita, ...]
    func generateFinalMenu(from piattiUtente: Dictionary<Piatto, Int>) {
        
//        withAnimation {
//            finalMenu = FinalMenuForMaster()
//
//            for user in creationState.users {
//                for item in user.orders {
//                    if finalMenu.menu[item.key] == nil {
//                        finalMenu.menu[item.key] = 0
//                    }
//                    finalMenu.menu[item.key]! += item.value
//                }
//            }
//
//            for piatto in piattiUtente {
//
//                if finalMenu.menu[Int(piatto.key.id)] == nil {
//                    finalMenu.menu[Int(piatto.key.id)] = 0
//                }
//                finalMenu.menu[Int(piatto.key.id)]! += piatto.value
//            }
//        }
//
        
    }
    
    
    
    func mqtt5(_ mqtt5: CocoaMQTT5, didReceiveMessage message: CocoaMQTT5Message, id: UInt16, publishData: MqttDecodePublish?) {
//        let topics = message.topic.split(separator: "/")
//
//        if topics.count == 2 {
//            let command = topics[1]
//            switch command {
//            case "newUser": handleNewUserJoin(user: message.string)
//                break
//            case "quitUser": handleUserQuit(user: message.string)
//                break
//            case "menu": newUserMenu(menuOfUser: message.string)
//                break
//            default:
//                print("Not Handled: \(command)")
//            }
//        }
    }

//    private func handleNewUserJoin(user: String?) {
//        if let user = user {
//            withAnimation {
//                creationState.users.append(UserFromNetwork(orders: [:], name: user))
//            }
//        }
//    }
//
//    private func handleUserQuit(user: String?) {
//        if let user = user {
//            let indexToRemove = creationState.users.firstIndex(where: { $0.name == user })
//            if let indexToRemove = indexToRemove {
//                withAnimation {
//                    _ = creationState.users.remove(at: indexToRemove)
//                }
//            }
//        }
//    }
//
//    // message body -> idtavolo,[idcibo:quantita, ...]
//    private func newUserMenu(menuOfUser: String?) {
//        if let menu = menuOfUser {
//            let data = menu.split(separator: ",")
//            if data.count > 0 {
//                var order: Dictionary<Int, Int> = [:]
//                let user = data[0]
//                for piatto in data[1..<data.count] {
//                    if piatto.split(separator: ":").count == 2 {
//                        let id = Int(piatto.split(separator: ":")[0])
//                        let quantita = Int(piatto.split(separator: ":")[1])
//                        if let id = id, let quantita = quantita {
//                            order[id] = quantita
//                        }
//                    }
//                }
//
//                withAnimation {
//                    creationState.users = creationState.users.filter( {$0.name != user} )
//                    creationState.users.append(UserFromNetwork(orders: order, name: String(user)))
//                }
//
//            }
//        }
//    }


    func mqtt5(_ mqtt5: CocoaMQTT5, didConnectAck ack: CocoaMQTTCONNACKReasonCode, connAckData: MqttDecodeConnAck?) {
        if let tableToConnect = tableToConnect, clientMQTT.connState == .connected {
            withAnimation {
                status = clientMQTT.connState
            }
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

