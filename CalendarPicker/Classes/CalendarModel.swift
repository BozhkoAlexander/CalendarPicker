//
//  CalendarModel.swift
//  CalendarPicker
//
//  Created by Alexander Bozhko on 24.03.2020.
//

import Foundation

private extension Calendar {
    
    func startOfMonth(for date: Date) -> Date {
        let components = dateComponents([.month, .year], from: date)
        return self.date(from: components) ?? date
    }
    
    func startOfWeek(for date: Date) -> Date {
        let components = dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        return self.date(from: components) ?? date
    }
    
    func weekDays(for date: Date) -> [Date] {
        let start = startOfWeek(for: date)
        return (0..<7).compactMap({
            self.date(byAdding: .day, value: $0, to: start)
        })
    }
    
    var weekdayCharacters: [String] {
        var weekdaySymbols = shortWeekdaySymbols
        weekdaySymbols.move(fromOffsets: IndexSet(integersIn: 0..<(firstWeekday - 1)), toOffset: weekdaySymbols.count)
        return weekdaySymbols.map({ String($0.prefix(1)) })
    }
    
}

private extension Date {
    
    var isPast: Bool {
        let today = Calendar.current.startOfDay(for: Date())
        return self < today
    }
    
}

public struct CalendarModel {
    
    // MARK: - Day item
    
    public struct DayItem: Hashable {
        
        var date: Date
                
        var text: String
        
        var isSelected: Bool
        
        var isAvailable: Bool
        
        var debugDesctiption: String {
            return text.isEmpty ? "_" : text
        }
        
    }
    
    // MARK: - Week item
    
    public struct WeekItem: Hashable {
        
        var debugDesctiption: String {
            return items.map({ $0.debugDesctiption }).joined(separator: ", ")
        }
        
        var items: [DayItem]
        
        init(_ weekDays: [Date], current: Date, selectedDate: Date?) {
            let calendar = Calendar.current
            let currentMonth = Calendar.current.dateComponents([.month], from: current).month!
            self.items = weekDays.map({ date in
                let comps = calendar.dateComponents([.month, .day], from: date)
                let text = comps.month == currentMonth ? String(format: "%i", comps.day!) : String()
                let isAvailable = !text.isEmpty && !date.isPast
                let isSelected = date == selectedDate
                return DayItem(date: date, text: text, isSelected: isSelected, isAvailable: isAvailable)
            })
        }
        
        mutating func select(_ item: DayItem) {
            for i in 0..<items.count {
                var _item = items[i]
                _item.isSelected = _item.date == item.date
                items[i] = _item
            }
        }
        
        var selectedItem: DayItem? {
            return items.filter({ $0.isSelected }).first
        }
        
    }
    
    // MARK: - Month item
    
    public struct MonthItem: Hashable {
        
        var debugDesctiption: String {
            return items.map({ $0.debugDesctiption }).joined(separator: "\n")
        }
        
        var title: String
        
        var items: [WeekItem]
        
        init(_ date: Date, selectedDate: Date?) {
            let calendar = Calendar.current
            let startOfMonth = calendar.startOfMonth(for: date)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "LLLL YYYY"
            title = formatter.string(from: startOfMonth)
            
            let numberOfWeeks = calendar.range(of: .weekOfMonth, in: .month, for: date)!.count
            self.items = (0..<numberOfWeeks).map({ i -> WeekItem in
                let next = calendar.date(byAdding: .weekOfMonth, value: i, to: startOfMonth)!
                let weekDays = calendar.weekDays(for: next)
                return WeekItem(weekDays, current: startOfMonth, selectedDate: selectedDate)
            })
        }
        
        mutating func select(_ item: DayItem) {
            for i in 0..<items.count {
                var _item = items[i]
                _item.select(item)
                items[i] = _item
            }
        }
        
        var selectedItem: DayItem? {
            return items.compactMap({ $0.selectedItem }).first
        }
        
    }
    
    // MARK: - Properties
        
    public var items: [MonthItem]
    
    public var columnNames: [String]
    
    public var debugDescription: String {
        return items.map({ $0.debugDesctiption }).joined(separator: "\n")
    }
    
    public var selectedItem: DayItem? {
        return items.compactMap({ $0.selectedItem }).first
    }
    
    // MARK: - Life cycle
    
    public init(_ availableDates: [Date] = [Date()], selectedDate: Date? = nil) {
        guard let from = availableDates.first, let to = availableDates.last else {
            items = []
            columnNames = []
            return
        }
        let calendar = Calendar.current
        var selected: Date? = nil
        if let selectedDate = selectedDate {
            selected = calendar.startOfDay(for: selectedDate)
        }
        let monthsCount = calendar.dateComponents([.month], from: from, to: to).month! + 1
        self.items = (0..<monthsCount).map({
            let nextDate = calendar.date(byAdding: .month, value: $0, to: from)!
            return MonthItem(nextDate, selectedDate: selected)
        })
        
        self.columnNames = calendar.weekdayCharacters
    }
    
    public mutating func select(_ item: DayItem) {
        guard item.isAvailable else { return }
        for i in 0..<items.count {
            var _item = items[i]
            _item.select(item)
            items[i] = _item
        }
    }
    
}
