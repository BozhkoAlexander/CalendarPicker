//
//  CalendarPickerController.swift
//  CalendarPicker
//
//  Created by Alexander Bozhko on 23.03.2020.
//

import UIKit
import SwiftUI

@available(iOS 13.0, *)
public class CalendarPickerController: UIHostingController<CalendarPickerView> {
    
    public init() {
        super.init(rootView: CalendarPickerView())
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
}
