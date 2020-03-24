//
//  CalendarGroup.swift
//  CalendarPicker
//
//  Created by Alexander Bozhko on 23.03.2020.
//

import SwiftUI

@available(iOS 13.0, *)
struct CalendarGroup: View {
    
    @State var model: CalendarModel
    
    // MARK: - Life cycle
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            ForEach(model.items, id: \.self) { month in
                VStack {
                    CalendarGroupHeader(title: month.title)
                    CalendarGroupSubtitle(model: self.model)
                    ForEach(month.items, id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(row.items, id: \.self) { item in
                                CalendarDayItem(item.text, isSelected: item.isSelected, isEnabled: item.isAvailable)
                                    .onTapGesture {
                                        self.model.select(item)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}

@available(iOS 13.0, *)
struct CalendarGroup_Previews: PreviewProvider {
    static var previews: some View {
        CalendarGroup(model: CalendarModel())
    }
}
