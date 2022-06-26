//
//  QRCodeView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 24/06/22.
//

import SwiftUI

struct QRCodeView: View {

    @EnvironmentObject var appPath: AppPath

    @State var isShareSheetShown = false


    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isShareSheetShown.toggle()
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .frame(height: 35)
            .padding()
            
            Spacer()
            
            Text("Codice: \(appPath.tableId)")
                .font(.title)
                .padding()
            
            Image(uiImage: UIImage(data: getQRCode(text: appPath.linkToShare()) ?? Data()) ?? UIImage())
                .resizable()
                .frame(width: 300, height: 300)
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $isShareSheetShown) {
            ShareView(activityItems: ["Partecipa al mio tavolo di Sushime! \(appPath.linkToShare())"])
                .ignoresSafeArea()
        }
    }
    
    func getQRCode(text: String) -> Data? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let data = text.data(using: .ascii, allowLossyConversion: false)
        filter.setValue(data, forKey: "inputMessage")
        guard let ciimage = filter.outputImage else { return nil }
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledCIImage = ciimage.transformed(by: transform)
        let uiimage = UIImage(ciImage: scaledCIImage)
        return uiimage.pngData()
    }

}

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView()
            .environmentObject(AppPath())
    }
}


struct ShareView: UIViewControllerRepresentable {

    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
        
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }

}
