//
//  AccountView.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 19/06/22.
//

import SwiftUI
import Foundation

struct AccountView: View {
    
    private let frameHeight = CGFloat(60)
    private let imageDimension = CGFloat(30)
    
    @AppStorage("name") var name: String = ""
    @AppStorage("surname") var surname: String = ""
    @AppStorage("username") var username: String = ""
    @AppStorage("profileImage") var profileImage: Data = Data()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink {
                        UserFormView(name: $name, surname: $surname, username: $username, profileImage: $profileImage)
                            .navigationTitle("Profilo")
                    } label: {
                        HStack {
                            if profileImage.isEmpty {
                                Image(systemName: "camera")
                                    .resizable()
                                    .frame(width: imageDimension, height: 25, alignment: .center)
                                    .padding(.trailing)
                            } else {
                                Image(uiImage: UIImage(data: profileImage)!)
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: 50, height: 50)
                                    .padding(.trailing)
                            }
                            Text(username == "" ? "Profilo" : username)
                                .font(.title2)
                            Spacer()
                            if needBadge() {
                                Image(systemName: "exclamationmark.circle.fill")
                                    .foregroundColor(.red)
                            }
                        }
                        .frame(height: frameHeight, alignment: .center)
                    }
                }
                
                Section {
                    NavigationLink {
                        OrderDetailView()
                            .navigationTitle("Ordini")
                    } label: {
                        Image(systemName: "cart")
                            .resizable()
                            .frame(width: imageDimension, height: imageDimension)
                            .padding(.trailing)
                        
                        Text("I Tuoi Ordini")
                            .font(.title2)
                    }
                    .frame(height: frameHeight, alignment: .center)
                }
                .navigationTitle("Account")
                .navigationBarTitleDisplayMode(.large)
            }
        }
    }
    
    
    
    func needBadge() -> Bool {
        name == "" || surname == "" || username == ""
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
