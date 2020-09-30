//
//  ContentView.swift
//  Caculator
//
//  Created by mayong on 2020/9/28.
//  Copyright © 2020 mayong. All rights reserved.
//

import SwiftUI

struct CalculatorButton: View {
    let fontSize: CGFloat = 38
    let title: String
    let size: CGSize
    let backgroundColorName: String
    let action: () -> Void

    var body: some View {
        Button(action: {
            print("button + ")
        }, label: {
            Text(title)
                .font(.system(size: fontSize))
                .foregroundColor(.white)
                .frame(width: size.width, height: size.height)
                .background(Color(backgroundColorName))
                .cornerRadius(size.width * 0.5)
        })
    }
}

struct CalculatorRow: View {
    @Binding var brain: CalculatorBrainWrapper
    let row: [CalculatorButtonItem]
    var body: some View {
        HStack {
            ForEach(row, id: \.self) { item in
                CalculatorButton(title: item.title,
                                 size: item.size,
                                 backgroundColorName: item.backgroundColorName,
                                 action: {
                                    self.brain = self.brain.apply(item: item)
                                     print("button \(item.title)")
                                 })
            }
        }
    }
}

struct CalculatorButtonPad: View {
    @Binding var brain: CalculatorBrainWrapper
    let pad: [[CalculatorButtonItem]] = [
        [.command(.clear), .command(.flip), .command(.percent), .op(.divide)],
        [.digit(7), .digit(8), .digit(9), .op(.multiply)],
        [.digit(4), .digit(5), .digit(6), .op(.minus)],
        [.digit(1), .digit(2), .digit(3), .op(.plus)],
        [.digit(0), .dot, .op(.equal)],
    ]

    var body: some View {
        VStack(spacing: 8) {
            ForEach(pad, id: \.self) { row in
                CalculatorRow(brain: self.$brain, row: row)
            }
        }
    }
}

struct ContentView: View {
    @State private var brain: CalculatorBrainWrapper = CalculatorBrainWrapper(brain: .left("0"))
    var body: some View {
        VStack(alignment: .trailing, spacing: 12) {
            Spacer()
            Text(brain.output)
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24)
                .lineLimit(1)
                .font(.system(size: 76))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            CalculatorButtonPad(brain: $brain)
                .padding(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
