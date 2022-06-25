//
//  CreateView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 23/06/22.
//

import SwiftUI

enum CreateViewStep {
    case created, order, confirm, result
}

struct CreateView: View {
    @State var createStep: CreateViewStep = .created
    
    @EnvironmentObject var appPath: AppPath
    
    @StateObject var mqtt = WrapperMQTT()

    @Binding var activeSheet: ActiveSheet?
    
    var body: some View {
        VStack {
            CreateTopbarView(activeSheet: $activeSheet)
            switch createStep {
            case .created: CreatedRoomView(createStep: $createStep)
            case .order: OrderMenuRoomView(createStep: $createStep)
            case .confirm: Text("Ordering")
            case .result: Text("Ordering")
            }
        }
        .padding()
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
