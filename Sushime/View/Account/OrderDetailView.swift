//
//  OrderDetailView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 25/06/22.
//

import SwiftUI

struct OrderDetailView: View {
    
    
    @FetchRequest(sortDescriptors: [])
    private var ordini: FetchedResults<Ordine>
    
    @State private var popup: Ordine?
    
    var body: some View {
        List {
            ForEach(ordini) { ordine in
                Button {
                    popup = ordine
                } label: {
                    Text("\(formatDate(date: ordine.data) ) - \(ordine.ristorante?.unwrappedNome ?? "error")")
                }
            }
            .sheet(item: $popup) { order in
                VStack {
                    Text("\(formatDate(date: order.data) ) - \(order.ristorante?.unwrappedNome ?? "error")")
                        .font(.largeTitle)
                    List(order.piattiArray) { piatto in
                        HStack {
                            Text("\(piatto.piatto?.unwrappedNome ?? "error")")
                            Spacer()
                            Text("\(piatto.quantita)")
                        }
                    }
                }
                .padding([.top])
            }
        }
    }
    
    
    func formatDate(date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date ?? Date())
    }
    
    struct Details: View {
        
        var ordine: Ordine
        
        var body: some View {
            List(ordine.piattiArray) { piatto in
                HStack {
                    Text("\(piatto.piatto?.unwrappedNome ?? "error")")
                    Spacer()
                    Text("\(piatto.quantita)")
                }
            }
        }
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView()
    }
}
