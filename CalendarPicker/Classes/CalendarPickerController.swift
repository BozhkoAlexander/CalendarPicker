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
    
    public var viewModel: CalendarModel
    
    public init(_ availableDates: [Date], selectedDate: Date?) {
        viewModel = CalendarModel(availableDates, selectedDate: selectedDate)
        super.init(rootView: CalendarPickerView(model: viewModel))
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
}
