//
//  JoinView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 23/06/22.
//

import SwiftUI


enum JoinViewStep {
    case order, confirm, waitResult
}

struct JoinView: View {
    
    @EnvironmentObject var appPath: AppPath
    
    @StateObject var mqtt = WrapperMQTTClient()

    @Binding var activeSheet: ActiveSheet?
    
    @State var selectedPiatti: Dictionary<Piatto, Int> = [:]
    @State var joinStep: JoinViewStep = .order
    
    var body: some View {
        VStack {
            JoinTopbarView(activeSheet: $activeSheet)
                .padding()
            if mqtt.status == .connected {
                switch joinStep {
                case .order: OrderMenuJoinRoomView(joinStep: $joinStep, selectedPiatti: $selectedPiatti)
                case .confirm: ConfirmMenuJoinRoomView(joinStep: $joinStep, selectedPiatti: $selectedPiatti)
                case .waitResult: Text("Wait Result")
                }
            } else {
                WaitingToJoinView()
            }
        }
        .environmentObject(mqtt)
        .onAppear {
            mqtt.subscribeTo(table: appPath.tableId)
        }
        .onDisappear {
            mqtt.unsubscribeFrom(table: appPath.tableId)
        }
    }
}

struct JoinView_Previews: PreviewProvider {
    static var previews: some View {
        JoinView(activeSheet: .constant(.join))
    }
}
