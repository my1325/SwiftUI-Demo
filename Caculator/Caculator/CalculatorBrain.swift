//
//  CalculatorBrain.swift
//  Caculator
//
//  Created by mayong on 2020/9/28.
//  Copyright © 2020 mayong. All rights reserved.
//

import Foundation

struct CalculatorBrainWrapper {
    let brain: CalculatorBrain
    
    private var formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.minimumFractionDigits = 0
        f.maximumFractionDigits = 8
         f.numberStyle = .decimal
        return f
    }()
    
    init(brain: CalculatorBrain) {
        self.brain = brain
    }
}

enum CalculatorBrain {
    case left(String) // 1
    case leftOp(
        left: String,
        op: CalculatorButtonItem.Op
    ) // 2
    case leftOpRight(
        left: String,
        op: CalculatorButtonItem.Op,
        right: String
    ) // 3
    case error // 4
}

extension CalculatorBrainWrapper {
    var output: String {
        var result: String = ""
        switch brain {
        case let .left(left): result = left // 其他 case
        case .leftOp(left: let left, op: let op):
            result = left
        case .leftOpRight(left: let left, op: let op, right: let right):
            result = right
        case .error:
            result = "Error"
        }
        guard let value = Double(result) else { return "Error" }
        return formatter.string(from: value as NSNumber)!
    }

    func apply(item: CalculatorButtonItem) -> CalculatorBrainWrapper {
        switch item {
        case let .digit(num): return apply(num: num)
        case .dot:
            return applyDot()
        case let .op(op):
            return apply(op: op)
        case let .command(command): return apply(command: command)
        }
    }
    
    func apply(num: Int) -> CalculatorBrainWrapper {
        switch brain {
        case let .left(left):
            return CalculatorBrainWrapper(brain: .left(Int(left) == 0 ? String(num) : left + String(num)))
        case let .leftOp(left, op):
            return CalculatorBrainWrapper(brain: .leftOpRight(left: left, op: op, right: String(num)))
        case let .leftOpRight(left, op, right):
            return CalculatorBrainWrapper(brain: .leftOpRight(left: left, op: op, right: right + String(num)))
        case .error:
            return CalculatorBrainWrapper(brain: .left(String(num)))
        }
    }
    
    func applyDot() -> CalculatorBrainWrapper {
        switch brain {
        case let .left(left):
            return CalculatorBrainWrapper(brain: .left(left + "."))
        case let .leftOp(left, op):
            return CalculatorBrainWrapper(brain: .leftOpRight(left: left, op: op, right: "0."))
        case let .leftOpRight(left, op, right):
            return CalculatorBrainWrapper(brain: .leftOpRight(left: left, op: op, right: right + "."))
        case .error:
            return CalculatorBrainWrapper(brain: .left("0."))
        }
    }
    
    func apply(command: CalculatorButtonItem.Command) -> CalculatorBrainWrapper {
        return CalculatorBrainWrapper(brain: .left(""))
    }
    
    func apply(op: CalculatorButtonItem.Op) -> CalculatorBrainWrapper {
        return CalculatorBrainWrapper(brain: .left(""))
    }
}

typealias CalculatorState = CalculatorBrainWrapper
typealias CalculatorStateAction = CalculatorButtonItem
struct Reducer {
    static func reduce(state: CalculatorState, action: CalculatorStateAction) -> CalculatorState {
        return state.apply(item: action)
    }
}
