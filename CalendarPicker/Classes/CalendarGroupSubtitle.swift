//
//  CalendarGroupSubtitle.swift
//  CalendarPicker
//
//  Created by Alexander Bozhko on 24.03.2020.
//

import SwiftUI

@available(iOS 13.0, *)
struct CalendarGroupSubtitle: View {
    
    @State var model: CalendarModel
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(model.columnNames, id: \.self) { name in
                Text(name)
                    .foregroundColor(.secondary)
                    .fontWeight(.medium)
                    .font(.caption)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(1, contentMode: .fit)
            }
        }
    }
    
}

@available(iOS 13.0, *)
struct CalendarGroupSubtitle_Previews: PreviewProvider {
    static var previews: some View {
        CalendarGroupSubtitle(model: CalendarModel())
    }
}
