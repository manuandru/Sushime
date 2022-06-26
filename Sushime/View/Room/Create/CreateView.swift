//
//  CreateView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 23/06/22.
//

import SwiftUI

enum CreateViewStep {
    case created, order, confirm, result, mergedMenu
}

struct CreateView: View {
    
    
    @EnvironmentObject var appPath: AppPath
    
    @StateObject var mqtt = WrapperMQTT()

    @Binding var activeSheet: ActiveSheet?
    
    @State var selectedPiatti: Dictionary<Piatto, Int> = [:]
    @State var createStep: CreateViewStep = .created
    
    var body: some View {
        VStack {
            CreateTopbarView(activeSheet: $activeSheet)
                .padding()
            if mqtt.status == .connected {
                switch createStep {
                case .created: CreatedRoomView(createStep: $createStep)
                case .order: OrderMenuRoomView(createStep: $createStep, selectedPiatti: $selectedPiatti)
                case .confirm: ConfirmMenuRoomView(createStep: $createStep, selectedPiatti: $selectedPiatti)
                case .result: ResultMenuRoomView(createStep: $createStep, selectedPiatti: $selectedPiatti)
                case .mergedMenu: MergedMenuRoomView(createStep: $createStep)
                }
            } else {
                WaitingForConnectionView()
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

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView(activeSheet: .constant(.create))
            .environmentObject(AppPath())
    }
}
