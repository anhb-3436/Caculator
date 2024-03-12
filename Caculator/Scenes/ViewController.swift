//
//  ViewController.swift
//  Caculator
//
//  Created by ho.bao.an on 12/03/2024.
//

import UIKit

final class ViewController: UIViewController {
    
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var result: Double = 0
    private var currentInput: String = ""
    private var previousNumber: Double = 0
    private var operation: String = ""
    private var isOperationPerformed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonACTapped(_ sender: Any) {
        currentInput = ""
        result = 0
        previousNumber = 0
        operation = ""
        isOperationPerformed = false
        displayLabel.text = "0"
    }
    
    @IBAction func buttonNumberTapped(_ sender: UIButton) {
        guard let numberText = sender.titleLabel?.text else { return }
        if isOperationPerformed {
            currentInput = ""
            isOperationPerformed = false
        }
        
        currentInput += numberText
        displayLabel.text = currentInput
    }
    
    @IBAction func buttonOperationTapped(_ sender: UIButton) {
        guard let operationText = sender.titleLabel?.text else { return }
        if currentInput.isEmpty {
            return
        }
        
        if operation.isEmpty {
            previousNumber = Double(currentInput) ?? 0
            currentInput = ""
            operation = operationText
        } else {
            performOperation()
            operation = operationText
        }
        
    }
    
    func performOperation() {
        guard let currentNumber = Double(currentInput) else { return }
        
        switch operation {
        case "+":
            result = previousNumber + currentNumber
        case "-":
            result = previousNumber - currentNumber
        case "*":
            result = previousNumber * currentNumber
        case "/":
            if currentNumber == 0 {
                displayLabel.text = "Error"
                return
            }
            result = previousNumber / currentNumber
        default:
            break
        }
        
        displayLabel.text = "\(result)"
        previousNumber = result
        isOperationPerformed = true
    }
    
    @IBAction func buttonEqualTapped(_ sender: Any) {
        performOperation()
        operation = ""
    }
    
    @IBAction func buttonNegativeTapped(_ sender: Any) {
        if currentInput.isEmpty {
            currentInput = "-"
        } else {
            if currentInput.first == "-" {
                currentInput.removeFirst()
            } else {
                currentInput.insert("-", at: currentInput.startIndex)
            }
        }
        displayLabel.text = currentInput
    }
    
    @IBAction func buttonPercentTapped(_ sender: Any) {
        guard let currentNumber = Double(currentInput) else { return }
        let percentValue = currentNumber * 0.01
        currentInput = "\(percentValue)"
        displayLabel.text = currentInput
    }
    
    @IBAction func buttonCommaTapped(_ sender: Any) {
        if !currentInput.contains(".") {
            currentInput += "."
        }
        displayLabel.text = currentInput
    }
}

