//
//  ViewController.swift
//  UiCalculator_Storyboard
//
//  Created by 머성이 on 6/24/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet var calButton: [UIButton]!
    var oper = "+-*/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = "0"
    }
    
    @IBAction func buttonTaped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        switch buttonTitle {
        case "AC":
            // 초기화 로직
            displayLabel.text = "0"
        case "=":
            // 계산 로직
            if let checkEqual = displayLabel.text, let lastChar = checkEqual.last {
                if oper.contains(lastChar) {
                    displayLabel.text = "Error"
                    return
                }
                
                if let result = calculate(expression: checkEqual) {
                    displayLabel.text = "\(result)"
                } else {
                    displayLabel.text = "Error"
                }
            }
        default:
            // 연산기호 중복 제거
            if let checkOper = displayLabel.text, let lastChar = checkOper.last {
                if oper.contains(lastChar) && oper.contains(buttonTitle) {
                    displayLabel.text?.removeLast()
                } else if checkOper == "0" && oper.contains(buttonTitle) {
                    // 첫째 자리에 연산기호 X
                    return
                }
            }
            
            // 기본값이 0일 때, 새로운 값으로 대체
            if displayLabel.text == "0" {
                displayLabel.text = buttonTitle
            } else {
                displayLabel.text = (displayLabel.text ?? "") + buttonTitle
            }
        }
    }
    
    func calculate(expression: String) -> Int? {
        let exp = NSExpression(format: expression)
        if let result = exp.expressionValue(with: nil, context: nil) as? NSNumber {
            return result.intValue
        } else {
            return nil
        }
    }
}
