//
//  UserFormView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 20/06/22.
//

import SwiftUI
import AVFoundation
import PhotosUI

struct UserFormView: View {
    
    @AppStorage("name") var name: String = ""
    @AppStorage("surname") var surname: String = ""
    @AppStorage("username") var username: String = ""
    @AppStorage("profileImage") var profileImage: Data = Data()
    
    @AppStorage("date") var data: Date = Date.now
    @State private var isImagePickerDisplay = false
    @State private var isLibraryPickerDisplay = false
    @State private var showAlert = false

    
    var body: some View {
        VStack {
            Menu {
                Button(action: takePhotoFromCamera) {
                    Label("Scatta", systemImage: "camera")
                }
                Button(action: takePhotoFromLibrary) {
                    Label("Seleziona da Libreria", systemImage: "photo")
                }
                Button(role: .destructive, action: deletePhoto) {
                    Label("Elimina", systemImage: "trash")
                }
            } label: {
                ZStack {
                    circleWithCameraAllert()
                    if !profileImage.isEmpty {
                        Image(uiImage: UIImage(data: profileImage)!)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 100, height: 100)
                    } else {
                        Image(systemName: "camera.fill")
                            .resizable()
                            .frame(width: 50, height: 40)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(width: 100, height: 100)
                .padding(.bottom)
            } primaryAction: {
                takePhotoFromCamera()
            }
            
            Group {
                TextField("Nome", text: $name)
                Divider()
                TextField("Cognome", text: $surname)
                Divider()
                TextField("Nickname", text: $username)
                Divider()
                DatePicker("Data di nascita", selection: $data, displayedComponents: .date)
                    .datePickerStyle(.compact)
            }
        }
        .sheet(isPresented: self.$isImagePickerDisplay) {
            ImagePickerView(selectedImage: $profileImage, sourceType: .camera)
                .ignoresSafeArea()
        }
        .sheet(isPresented: $isLibraryPickerDisplay) {
            PhotoPicker(pickerResult: $profileImage, isPresented: $isLibraryPickerDisplay)
                .ignoresSafeArea()
        }
    }
    
    func takePhotoFromCamera() {
        AVCaptureDevice.requestAccess(for: .video) { accessGranted in
            if accessGranted {
                isImagePickerDisplay.toggle()
            } else {
                showAlert.toggle()
            }
        }

    }
    
    func takePhotoFromLibrary() {
        isLibraryPickerDisplay.toggle()
    }
    
    func deletePhoto() {
        profileImage = Data()
    }
    
    
    func circleWithCameraAllert() -> some View {
        Circle()
            .stroke(Color(uiColor: .secondaryLabel), lineWidth: 5)
            .shadow(color: .primary, radius: 15)
            .alert(
                Text("Per questa funzione è necessario l'accesso alla fotocamera"),
                isPresented: $showAlert,
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

struct UserFormView_Previews: PreviewProvider {
    static var previews: some View {
        UserFormView()
    }
}


// To save date in app storage
extension Date: RawRepresentable {
    private static let formatter = ISO8601DateFormatter()
    
    public var rawValue: String {
        Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}
