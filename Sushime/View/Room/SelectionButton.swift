//
//  SelectionButton.swift
//  Sushime
//
//  Created by Manuel Andruccioli on 19/06/22.
//

import SwiftUI

struct SelectionButton: View {
    
    let action: () -> ()
    let content: String
    let image: String
    let color: UIColor
    
    private let opacity = 0.8
    private let imageFrameSize = CGFloat(60)
    private let buttonFrameSize = CGFloat(175)
    private let cornerRadius = CGFloat(60)
    
    var body : some View {
        Button {
            action()
        } label: {
            ZStack {
                Color(color)
                    .opacity(opacity)
                HStack() {
                    Spacer()
                    Text(content)
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: image)
                        .resizable()
                        .frame(width: imageFrameSize, height: imageFrameSize, alignment: .center)
                    Spacer()
                }
                .font(.largeTitle)
                .foregroundColor(.black)
            }
            .frame(height: buttonFrameSize, alignment: .center)
            
        }
        .cornerRadius(cornerRadius)
        .padding([.top, .bottom])
    }
}

