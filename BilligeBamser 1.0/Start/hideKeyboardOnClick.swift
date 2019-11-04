//
//  hideKeyboardOnClick.swift
//  BilligeBamser 1.0
//
//  Created by Nicolai Dam on 04/11/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//
import UIKit
class hideKeyboardOnClick: UIViewController {
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}
