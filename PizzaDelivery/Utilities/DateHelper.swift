//
//  DateHelper.swift
//  PizzaDelivery
//
//  Created by Meryem Demir on 22.01.2026.
//

import Foundation

struct DateHelper {
    // Belirli bir tarih oluşturur (gün, ay, yıl)
    static func createDate(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0) -> Date? {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        return Calendar.current.date(from: components)
    }
    
    // Bugünün tarihini başlangıç günü olarak alır (saat 00:00)
    static func today() -> Date {
        return Calendar.current.startOfDay(for: Date())
    }
    
    // Tarih formatını string'e çevirir (örn: "14 Ocak 2026")
    static func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "d MMMM"
        return formatter.string(from: date)
    }
}
