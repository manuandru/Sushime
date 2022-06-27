//
//  RoomView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 19/06/22.
//

import SwiftUI
import CodeScanner
import AVFoundation

struct RoomView: View {
    @EnvironmentObject var appPath: AppPath
    
    @State var isCameraAlertShown = false
    @State var isInvalidQRAlertShown = false
    
    var body: some View {
        NavigationView {
            LazyVStack {
                Button {
                    openCameraIfPossible()
                } label: {
                    VStack {
                        Image(systemName: "qrcode.viewfinder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                        Text("Scannerizza codice QR")
                            .font(.title)
                    }
                }
                .navigationTitle("Stanza")
                .navigationBarTitleDisplayMode(.large)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            appPath.activeSheet = .selectingRestaurantToCreate
                        } label: {
                            Text("Crea stanza")
                            Image(systemName: "plus")
                        }
                        Button {
                            appPath.activeSheet = .selectingTable
                        } label: {
                            Text("Inserisci codice")
                            Image(systemName: "keyboard")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }

                }
            }
            .fullScreenCover(item: $appPath.activeSheet) { sheet in
                switch sheet {
                case .join: JoinView(activeSheet: $appPath.activeSheet)
                case .selectingRestaurantToCreate: RestaurantSelectionToCreateView(activeSheet: $appPath.activeSheet)
                case .selectingTable: SelectTableToJoinView(activeSheet: $appPath.activeSheet)
                case .create: CreateView(activeSheet: $appPath.activeSheet)
                case .scanner:
                    ZStack {
                        CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
                            .ignoresSafeArea()
                            .alert(
                                "Nessun codice QR valido rilevato.",
                                isPresented: $isInvalidQRAlertShown,
                                actions: {
                                    Button(role: .cancel) {
                                        appPath.activeSheet = .none
                                     } label: {
                                         Text("Ok")
                                     }
                                }
                        )
                        VStack {
                            HStack {
                                Button {
                                    withAnimation {
                                        appPath.activeSheet = .none
                                    }
                                } label: {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .padding()
                                        .foregroundColor(.white)
                                }
                                Spacer()
                            }
                            Spacer()
                        }
                    } //END ZStack
                } //END switch
            } //END fullScreenCover
            .alert(
                Text("Per questa funzione è necessario l'accesso alla fotocamera"),
                isPresented: $isCameraAlertShown,
                actions: {
                    Button(role: .cancel) {
                     } label: {
                         Text("Non ora")
                     }
                     Button {
                         UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                     } label: {
                         Text("Impostazioni")
                     }
                 },
                message:  {
                     Text("Nelle impostazioni dell'iPhone, tocca Sushime e attiva l'accesso alla fotocamera")
                 }
            )

            
        }
    }
    
    func openCameraIfPossible() {
        AVCaptureDevice.requestAccess(for: .video) { accessGranted in
            DispatchQueue.main.async {
                if accessGranted {
                    appPath.activeSheet = .scanner
                } else {
                    isCameraAlertShown.toggle()
                }
            }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        switch result {
        case .success(let result):
            if result.string.starts(with: "sushime://table/") {
                appPath.activeSheet = .join
                appPath.tableId = String(result.string.split(separator: "/")[2])
            } else {
                isInvalidQRAlertShown.toggle()
                return
            }
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}

struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView()
            .environmentObject(AppPath())
    }
}
