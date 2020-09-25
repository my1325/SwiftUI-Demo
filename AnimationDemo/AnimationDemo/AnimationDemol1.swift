//
//  AnimationDemol1.swift
//  AnimationDemo
//
//  Created by mayong on 2020/9/25.
//  Copyright © 2020 mayong. All rights reserved.
//

import SwiftUI

struct AnimationDemo1: View {
    @State var animationAmount: CGFloat = 1
    var body: some View {
        Button("Tap Me") {
            // self.animationAmount += 1
        }
        .padding(40)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeOut(duration: 1)
                        .repeatForever(autoreverses: true)
                )
        )
        .onAppear {
            self.animationAmount = 2
        }
    }
}

struct AnimationDemo1_Previews: PreviewProvider {
    static var previews: some View {
        AnimationDemo1()
    }
}
