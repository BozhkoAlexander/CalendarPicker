//
//  CalendarDayItem.swift
//  CalendarPicker
//
//  Created by Alexander Bozhko on 23.03.2020.
//

import SwiftUI

@available(iOS 13.0, *)
struct CalendarDayItem: View {
    
    // MARK: - Properties
    
    var text: String
    
    var isSelected: Bool

    var isEnabled: Bool
    
    // MARK: - Computed
    
    private var fontWeight: Font.Weight {
        return isSelected ? .bold : .medium
    }
    
    private var foregroundColor: Color {
        if !isEnabled { return .secondary }
        return isSelected ? .white : .primary
    }
    
    private var backgroundColor: Color? {
        if !isEnabled { return nil }
        return isSelected ? Color.blue : nil
    }
    
    // MARK: - Life cycle
        
    init(_ text: String, isSelected: Bool, isEnabled: Bool) {
        self.text = text
        self.isSelected = isSelected
        self.isEnabled = isEnabled
    }
    
    var body: some View {
        Text(text)
            .fontWeight(fontWeight)
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .aspectRatio(1, contentMode: .fit)
    }
}

@available(iOS 13.0, *)
struct CalendarDayItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalendarDayItem("29", isSelected: false, isEnabled: true)
            CalendarDayItem("24", isSelected: true, isEnabled: true)
            CalendarDayItem("1", isSelected: false, isEnabled: false)
        }
        .previewLayout(.fixed(width: 44, height: 44))
    }
}
