//
//  InputView.swift
//  FakeWeather
//
//  Created by Luy Nguyen on 1/14/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//


import UIKit

class InputView: UIView {
    @IBOutlet weak var lbTitle: KHLabel!
    @IBOutlet weak var btnSelect: KHButton!
    @IBOutlet weak var tfValue: KHTextField!
    @IBOutlet weak var viewInput: UIView!
    @IBOutlet weak var viewSelection: UIView!
    @IBOutlet weak var viewTempC: UIView!
    @IBOutlet weak var viewTempF: UIView!
    
    @IBInspectable open var title: String = "" {
        didSet {
            lbTitle.text = title.localized
        }
    }
    
    @IBInspectable open var type: Int = 0 {
        didSet {
            switch type {
            case 0:
                viewInput.isHidden = false
                btnSelect.isHidden = true
                viewSelection.isHidden = true
                tfValue.keyboardType = .default
                break
            case 1:
                viewInput.isHidden = false
                btnSelect.isHidden = true
                viewSelection.isHidden = true
                tfValue.keyboardType = .decimalPad
                break
            case 2:
                viewInput.isHidden = true
                btnSelect.isHidden = true
                viewSelection.isHidden = false
                break
            case 3:
                viewInput.isHidden = false
                btnSelect.isHidden = false
                viewSelection.isHidden = true
                break
            default:
                break
            }
        }
    }
    
    @IBInspectable open var text: String = "" {
        didSet {
            tfValue.text = text
            textOutput = text
        }
    }
    
    var textOutput: String = ""
    var handleSelectItem: (() -> ())?
    var handleTypeTemp: ((typeTemp) -> ())?
    
    @IBAction func actionSelect(_ sender: Any) {
        handleSelectItem?()
    }
    
    @IBAction func actionTempC(_ sender: Any) {
        viewTempC.backgroundColor = .white
        viewTempF.backgroundColor = .clear
        handleTypeTemp?(.tempC)
    }
    
    @IBAction func actionTempF(_ sender: Any) {
        viewTempC.backgroundColor = .clear
        viewTempF.backgroundColor = .white
        handleTypeTemp?(.tempF)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "InputView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        GCDCommon.mainQueue {
            self.viewSelection.roundCorners(corners: [.topRight, .bottomRight], radius: 6, showBorder: true)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension InputView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            self.textOutput = updatedText
        }
        return true
    }
}
