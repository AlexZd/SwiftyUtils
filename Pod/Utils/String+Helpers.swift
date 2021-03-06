//
//  String+Helpers.swift
//
//  Created by Alex Zdorovets on 6/17/15.
//  Copyright (c) 2015 Alex Zdorovets. All rights reserved.
//

import Foundation

extension String {
    /** Returns localizedUppercaseString for iOS 9+ or uppercaseString for below */
    public var up: String {
        if #available(iOS 9, *) {
            return self.localizedUppercase
        }
        return self.uppercased()
    }
    
    /** Returns localizedLowercaseString for iOS 9+ or lowercaseString for below */
    public var down: String {
        if #available(iOS 9, *) {
            return self.localizedLowercase
        }
        return self.lowercased()
    }
    
    /** Returns localizedCapitalizedString for iOS 9+ or capitalizedString for below */
    public var cap: String {
        if #available(iOS 9, *) {
            return self.localizedCapitalized
        }
        return self.capitalized
    }
    
    /** Returns string with first capitalized letter */
    public var capFirst: String {
        return String(characters.prefix(1)).up + String(self.characters.dropFirst())
    }
    
    /** Converts String to Gregorian NSDate */
    public func toDate(_ mask: String) -> Date? {
        let dateFormatter = DateFormatter(dateFormat: mask)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        return dateFormatter.date(from: self)
    }
    
    /** Returns truncated string with ending which you spicify in trailing */
    public func truncate(length: Int, trailing: String? = nil) -> String {
        if self.characters.count > length {
            let index = self.index(self.startIndex, offsetBy: length)
            return String(self[..<index]) + (trailing ?? "")
        } else {
            return self
        }
    }
    
    /** Returns `true` in case string contains substring */
    func contains(substring: String) -> Bool {
        return self.ranges(of: substring) != nil
    }
    
    /** Returns array of ranges of substring */
    public func ranges(of string: String) -> Array<NSRange> {
        var searchRange = NSMakeRange(0, self.characters.count)
        var ranges : Array<NSRange> = []
        
        while searchRange.location < self.characters.count {
            searchRange.length = self.characters.count - searchRange.location
            let foundRange = (self as NSString).range(of: string, options: .caseInsensitive, range: searchRange)
            if foundRange.location != NSNotFound {
                ranges.append(foundRange)
                searchRange.location = foundRange.location + foundRange.length
            } else {
                break
            }
        }
        return ranges
    }
    
    /** Trim whitespacesAndNewlines */
    public func trim(set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {
        return self.trimmingCharacters(in: set)
    }
    
    public func height(width: CGFloat, font: UIFont?) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        var attributes: [NSAttributedString.Key: Any] = [:]
        if let font = font {
            attributes[.font] = font
        }
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    public func width(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    /// Returns values from string with RegExp pattern
    public func regexValues(with pattern: String) -> [String] {
        var results: [String] = []
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let matches = regex.matches(in: self, options: [], range: NSRange(self.startIndex..., in: self))
            for match in matches {
                let lastRangeIndex = match.numberOfRanges - 1
                guard lastRangeIndex >= 1 else { return results }
                
                for i in 1...lastRangeIndex {
                    let capturedGroupIndex = match.range(at: i)
                    let matchedString = (self as NSString).substring(with: capturedGroupIndex)
                    results.append(matchedString)
                }
            }
            return results
        } catch {
            return results
        }
    }
}
