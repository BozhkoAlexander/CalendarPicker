//
//  CalendarPickerView.swift
//  CalendarPicker
//
//  Created by Alexander Bozhko on 23.03.2020.
//

import SwiftUI

@available(iOS 13.0, *)
public struct CalendarPickerView: View {
    
    @State var model: CalendarModel
    
    public var body: some View {
        VStack {
            CalendarGroup(model: model)
        }
        .padding()
    }
    
}

@available(iOS 13.0, *)
struct CalendarPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarPickerView(model: CalendarModel(selectedDate: Date()))
    }
}
