//
//  ReservedTeacherManager.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/21/25.
//

import Foundation

class ReservedTeacherManager {
    static let shared = ReservedTeacherManager()

    private let key = "ReservedTeacherList"

    func add(_ teacher: Teacher) {
        var current = getReservedTeachers()

        if !current.contains(where: { $0.id == teacher.id }) {
            current.append(teacher)
            save(current)
        }
    }

    func getReservedTeachers() -> [Teacher] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let teachers = try? JSONDecoder().decode([Teacher].self, from: data) else {
            return []
        }
        return teachers
    }

    func getTotalReservedCoin() -> Int {
        return getReservedTeachers().reduce(0) { $0 + ( $1.teacherReserveCoin ?? 0 ) }
    }

    func save(_ teachers: [Teacher]) {
        if let data = try? JSONEncoder().encode(teachers) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func removeAll() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
