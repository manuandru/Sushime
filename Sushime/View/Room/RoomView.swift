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
                .navigationTitle("Room")
                .navigationBarTitleDisplayMode(.large)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            appPath.activeSheet = .create
                        } label: {
                            Text("Crea stanza")
                            Image(systemName: "plus")
                        }
                        Button {
                            appPath.activeSheet = .join
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
                case .join: JoinView()
                case .create: CreateView()
                case .scanner:
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
                }
            }
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
                appPath.tableId = "1"
                print(result.string.split(separator: "/"))
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
