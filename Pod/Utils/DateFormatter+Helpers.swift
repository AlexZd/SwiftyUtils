//
//  NSDateFormatter+Helpers.swift
//
//  Created by Alex Zdorovets on 6/27/16.
//
//

import Foundation

extension DateFormatter {
    public convenience init(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) {
        self.init()
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
    }
    
    public convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
    
    public convenience init(dateStyle: DateFormatter.Style) {
        self.init(dateStyle: dateStyle, timeStyle: .none)
    }
    
    public convenience init(timeStyle: DateFormatter.Style) {
        self.init(dateStyle: .none, timeStyle: timeStyle)
    }   
}

final public class UTCDateFormatter: DateFormatter {
    override init() {
        super.init()
        self.timeZone = TimeZone(abbreviation: "UTC")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
