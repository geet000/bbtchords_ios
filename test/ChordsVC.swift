//
//  ChordsVC.swift
//  test
//
//  Created by Value edge solution on 05/09/17.
//  Copyright © 2017 Value edge solution. All rights reserved.
//

import Foundation
import UIKit

class ChordsVC:BaseViewController,UITextViewDelegate{
    @IBOutlet var txtChords: UITextView!
    static var name = ""
    static var chords=""
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        self.title=ChordsVC.name
        txtChords.delegate=self
        txtChords.text=ChordsVC.chords
        txtChords.contentOffset=CGPoint.zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
    
}
