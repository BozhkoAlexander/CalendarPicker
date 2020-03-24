//
//  CalendarGroupHeader.swift
//  CalendarPicker
//
//  Created by Alexander Bozhko on 24.03.2020.
//

import SwiftUI

struct CalendarGroupHeader: View {
    
    var title: String
    
    @available(iOS 13.0, *)
    var body: some View {
        
        HStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            Spacer()
        }
        .padding(.top, 20)
        
    }
}

struct CalendarGroupHeader_Previews: PreviewProvider {
    
    @available(iOS 13.0, *)
    static var previews: some View {
        CalendarGroupHeader(title: "May 2020")
    }
    
}
