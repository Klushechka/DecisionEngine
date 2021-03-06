//
//  LoanDecisionViewController.swift
//  DecisionEngine
//
//  Created by Olga Kliushkina on 04.06.2020.
//  Copyright © 2020 Olga Klyushkina. All rights reserved.
//

import Foundation
import UIKit

final class LoanDecisionViewController: UIViewController {
    
    @IBOutlet weak var idCodeTitleLabel: TitleLabel!
    @IBOutlet weak var idCodeTextField: BorderlessTextField!
    @IBOutlet weak var idInfoLabel: UILabel!
    
    @IBOutlet weak var loanAmountTitleLabel: TitleLabel!
    @IBOutlet weak var loanAmountTextField: BorderlessTextField!
    @IBOutlet weak var loanAmountPickerView: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var loanPeriodTitleLabel: TitleLabel!
    @IBOutlet weak var loanPeriodTextField: BorderlessTextField!
    @IBOutlet weak var periodPickerView: UIPickerView!
    
    @IBOutlet weak var applyButton: UIButton!
    
    @IBOutlet weak var approvalResultLabel: UILabel!
    @IBOutlet weak var maxLoanSumLabel: UILabel!
    
    private var viewModel: LoanDecisionViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewModelAndCallbacks()
        fillInContent()
        decorateElements()
        setUpPickerViews()
        
        prepareTextFields()
    }
    
    private func fillInContent() {
        self.idCodeTitleLabel.text = Constants.idCodeTitle
        self.idCodeTextField.placeholder = Constants.idCodePlaceholder
        self.idInfoLabel.text = Constants.idCodeInfoLabel
        
        self.currencyLabel.text = Constants.euroCurrency
        
        self.loanAmountTitleLabel.text = Constants.loanAmountTitle
        self.loanAmountTextField.placeholder = "0"
        
        self.loanPeriodTitleLabel.text = Constants.loanPeriodTitle
        self.loanPeriodTextField.placeholder = "0"
        
        self.applyButton.setTitle(Constants.applyTitle, for: .normal)
    }
    
    private func decorateElements() {
        self.currencyLabel.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        self.currencyLabel.textColor = .darkGray
        
        self.idInfoLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        self.idInfoLabel.textColor = .lightGray
        
        self.applyButton.isEnabled = false
        self.applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        
        self.approvalResultLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        self.approvalResultLabel.textColor = .darkGray
        
        self.maxLoanSumLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        self.maxLoanSumLabel.textColor = .darkGray
    }
    
    private func removeDecisionShowApplyButton() {
        self.approvalResultLabel.text = ""
        self.maxLoanSumLabel.text = ""
        
        self.applyButton.isHidden = false
    }
    
    private func setUpViewModelAndCallbacks() {
        self.viewModel = LoanDecisionViewModelImpl()
        
        setUpErrorCallback()
        setUpDecisionCallback()
    }
    
    private func setUpErrorCallback() {
        self.viewModel?.errorOccured = { [weak self] error in
            guard let self = self else { return }
            
            var alertMessage: String
            
            switch error {
            case .idCodeUnknown:
                alertMessage = Constants.idCodeNotFound
            case .wrongCodeCharsNumber:
                alertMessage = Constants.wrongCodeCharsNumber
            }
            
            self.showDefaultStyleAlert(title: Constants.errorOccured, message: alertMessage, buttonLabel: Constants.closeButton)
        }
    }
    
    private func setUpDecisionCallback() {
        self.viewModel?.loanDecisionCompleted = { [weak self] isCurrentLoanApprovable, maxLoanSum in
            guard let self = self else { return }
            
            if maxLoanSum == 0 {
                self.approvalResultLabel.text = Constants.loanCanNotBeApproved
            }
            else if maxLoanSum > 0 {
                let canOrNot = isCurrentLoanApprovable ? Constants.canCaps : Constants.canNotCaps
                
                self.approvalResultLabel.text = String(format: Constants.isLoanApprovable, canOrNot)
                self.maxLoanSumLabel.text = maxLoanSum > 0 ? String(format: Constants.maxLoanAmountIs, String(maxLoanSum)) : ""
            }
            
            self.applyButton.isHidden = true
        }
    }
    
    @IBAction func applyButtonTapped(_ sender: Any) {
        guard let viewModel = self.viewModel,
            let idCodeText = self.idCodeTextField.text,
            let amount = Int(self.loanAmountTextField.text ?? ""),
            let period = Int(self.loanPeriodTextField.text ?? "") else {
                return
        }
        
        self.periodPickerView.isHidden = true
        self.loanAmountPickerView.isHidden = true
        
        let request = LoanRequest(idCode: idCodeText, desiredLoanAmount: amount, desiredLoanPeriod: period)
        viewModel.resultForRequest(request)
    }
    
}

extension LoanDecisionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case self.loanAmountPickerView: return self.viewModel?.loanAmountOptions?.count ?? 0
        case self.periodPickerView: return self.viewModel?.loanPeriodOptions?.count ?? 0
        default: break
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let viewModel = self.viewModel else { return nil }
        
        var option = 0
        
        if pickerView == self.periodPickerView, let periodOption = viewModel.loanPeriodOptions?[row] {
            option = periodOption
        }
        else if let amountOption = viewModel.loanAmountOptions?[row]{
            option = amountOption
        }
        
        return String(option)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let viewModel = self.viewModel else { return }
        
        if pickerView == self.periodPickerView, let periodOption = viewModel.loanPeriodOptions?[row] {
            self.loanPeriodTextField.text = String(periodOption)
            self.periodPickerView.isHidden = true
        }
        else if let amountOption = viewModel.loanAmountOptions?[row] {
            self.loanAmountTextField.text = String(amountOption)
            self.loanAmountPickerView.isHidden = true
        }
        
        enableApplyButtonIfNeeded()
    }
    
    internal func setUpPickerViews() {
        let pickerViews = [self.periodPickerView, self.loanAmountPickerView]
        
        pickerViews.forEach {
            $0?.delegate = self
            $0?.dataSource = self
            
            $0?.isHidden = true
            $0?.addBorder()
            $0?.backgroundColor = .white
        }
    }
    
}

extension LoanDecisionViewController: UITextFieldDelegate {
    
    private func prepareTextFields() {
        becomeTextFieldsDelegate()
        addTargets()
    }
    
    private func addTargets() {
        self.idCodeTextField.addTarget(self, action: #selector(enableApplyButtonIfNeeded), for: .editingDidEnd)
        self.idCodeTextField.addDoneButtonToKeyboard(myAction:  #selector(self.idCodeTextField.resignFirstResponder))
    }
    
    @objc private func enableApplyButtonIfNeeded() {
        guard let loanAmountText = self.loanAmountTextField.text, let idCodeText = self.idCodeTextField.text, let amountPeriodText = self.loanPeriodTextField.text else { return }
        
        self.applyButton.isEnabled = !loanAmountText.isEmpty && !idCodeText.isEmpty && !amountPeriodText.isEmpty
    }
    
    func becomeTextFieldsDelegate() {
        self.idCodeTextField.delegate = self
        self.loanAmountTextField.delegate = self
        self.loanPeriodTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        removeDecisionShowApplyButton()
        
        if textField == self.idCodeTextField {
            prepareForEditingCode()
        }
        else if textField == self.loanAmountTextField {
            prepareForEditingAmount()
        }
        else if textField == self.loanPeriodTextField {
            prepareForEditingPeriod()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        enableApplyButtonIfNeeded()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 11
    }
    
}

private extension LoanDecisionViewController {
    
    func prepareForEditingCode() {
        self.idCodeTextField.keyboardType = .numberPad
        self.loanAmountPickerView.isHidden = true
        self.periodPickerView.isHidden = true
    }
    
    func prepareForEditingAmount() {
        if let text = self.loanAmountTextField.text, text.isEmpty, let loanAmountOption = self.viewModel?.loanAmountOptions?.first {
            self.loanAmountTextField.text = String(loanAmountOption)
        }
        
        self.loanAmountPickerView.isHidden = !self.loanAmountPickerView.isHidden
        self.periodPickerView.isHidden = true
        
        self.view.endEditing(true)
    }
    
    func prepareForEditingPeriod() {
        if let text = self.loanPeriodTextField.text, text.isEmpty, let loanPeriodOption = self.viewModel?.loanPeriodOptions?.first {
            self.loanPeriodTextField.text = String(loanPeriodOption)
        }
        
        self.periodPickerView.isHidden = !self.periodPickerView.isHidden
        self.loanAmountPickerView.isHidden = true
        
        self.view.endEditing(true)
    }
    
}
