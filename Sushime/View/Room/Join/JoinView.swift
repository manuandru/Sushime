//
//  JoinView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 23/06/22.
//

import SwiftUI


enum JoinViewStep {
    case waitingToJoin, order, confirm, waitResult
}

struct JoinView: View {
    
    @EnvironmentObject var appPath: AppPath
    
    @StateObject var mqtt = WrapperMQTTClient()

    @Binding var activeSheet: ActiveSheet?
    
    @State var selectedPiatti: Dictionary<Piatto, Int> = [:]
    @State var joinStep: JoinViewStep = .waitingToJoin
    
    var body: some View {
        VStack {
            JoinTopbarView(activeSheet: $activeSheet)
                .padding()
            switch joinStep {
            case .waitingToJoin: WaitingToJoinView()
            case .order: Text("Order")
            case .confirm: Text("Confirm")
            case .waitResult: Text("Wait Result")
            }
        }
        .environmentObject(mqtt)
//        .onAppear {
//            mqtt.subscribeTo(table: appPath.tableId)
//        }
//        .onDisappear {
//            mqtt.unsubscribeFrom(table: appPath.tableId)
//        }
    }
}

struct JoinView_Previews: PreviewProvider {
    static var previews: some View {
        JoinView(activeSheet: .constant(.join))
    }
}
