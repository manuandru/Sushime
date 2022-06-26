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
    
    @Published var finalMenu: Dictionary<Int, Int> = [:]
    
    var username: String = ""
    
    var restaurantId: Int?
    
    
    var tableId: String?
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
        print("Chiusura socket")
    }

    func subscribeTo(table: String, username: String) {
//        creationState = CreationState()
        tableId = table
        tableToConnect = "\(table)/#"
        self.username = username
    }

    func unsubscribeFrom() {
        if let tableToConnect = tableToConnect, clientMQTT.connState == .connected {
            clientMQTT.unsubscribe(tableToConnect)
            clientMQTT.publish("\(tableId ?? "")/quitUser", withString: username, properties: MqttPublishProperties())
        }
        tableToConnect = .none
    }
    
    // [idcibo:quantita, ...]
    func publishFinalMenu(from piattiUtente: Dictionary<Piatto, Int>) {
        
        var myMenu: String = "\(username)"
        
        for piatto in piattiUtente {
            myMenu += ",\(piatto.key.id):\(piatto.value)"
        }
        
        clientMQTT.publish("\(tableId ?? "")/menu", withString: myMenu, properties: MqttPublishProperties())
        
    }
    
    
    
    func mqtt5(_ mqtt5: CocoaMQTT5, didReceiveMessage message: CocoaMQTT5Message, id: UInt16, publishData: MqttDecodePublish?) {
        let topics = message.topic.split(separator: "/")

        if topics.count == 2 {
            let command = topics[1]
            switch command {
            case "finalMenu": handleFinalMenu(menu: message.string)
                break
            default:
                print("Not Handled: \(command)")
            }
        }
    }
    
    // message body -> idristorante,[idcibo:quantita, ...]
    private func handleFinalMenu(menu: String?) {
        if let menu = menu {
            let data = menu.split(separator: ",")
            if data.count > 0 {
                restaurantId = Int(data[0])
                for piatto in data[1..<data.count] {
                    if piatto.split(separator: ":").count == 2 {
                        let id = Int(piatto.split(separator: ":")[0])
                        let quantita = Int(piatto.split(separator: ":")[1])
                        if let id = id, let quantita = quantita {
                            withAnimation {
                                finalMenu[id] = quantita
                            }
                        }
                    }
                }
                
            }
        }
    }


    func mqtt5(_ mqtt5: CocoaMQTT5, didConnectAck ack: CocoaMQTTCONNACKReasonCode, connAckData: MqttDecodeConnAck?) {
        if let tableToConnect = tableToConnect, clientMQTT.connState == .connected {
            withAnimation {
                status = clientMQTT.connState
            }
            clientMQTT.subscribe(tableToConnect)
            clientMQTT.publish("\(tableId ?? "")/newUser", withString: username, properties: MqttPublishProperties())
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
        withAnimation {
            status = .disconnected
        }
    }
}

