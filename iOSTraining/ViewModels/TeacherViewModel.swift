//
//  TeacherViewModel.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/19/25.
//

import Foundation
import Combine
import UIKit

class TeacherViewModel: ObservableObject {
    @Published var teacher: Teacher
    @Published var isReserved: Bool = false

    var isFavorite: Bool {
        UserDefaults.standard.isFavorite(id: teacher.id ?? 0)
    }

    init(teacher: Teacher) {
        self.teacher = teacher
        self.isReserved = ReservedTeacherManager.shared
            .getReservedTeachers()
            .contains(where: { $0.id == teacher.id })
    }

    func toggleFavorite() {
        guard let id = teacher.id else { return }

        if teacher.isFavorite {
            teacher.isFavorite.toggle()
            UserDefaults.standard.removeFavorite(id: id)

            if let currentCount = teacher.favoriteCount, currentCount > 0 {
                teacher.favoriteCount = currentCount - 1
            }
        } else {
            teacher.isFavorite.toggle()
            UserDefaults.standard.addFavorite(id: id)

            teacher.favoriteCount = (teacher.favoriteCount ?? 0) + 1
        }
    }

    func refreshFavoriteStatus() {
        objectWillChange.send()
    }

    func reserveTeacher() {
        var reserved = ReservedTeacherManager.shared.getReservedTeachers()

        if let id = teacher.id,
            let index = reserved.firstIndex(where: { $0.id == id}){
            reserved.remove(at: index)
        }else{
            reserved.append(teacher)
        }

        ReservedTeacherManager.shared.save(reserved)
        isReserved = reserved.contains(where: { $0.id == teacher.id })
    }

    var favoriteImageName: String {
        isFavorite ? "heart.fill" : "heart"
    }

    var favoriteTintColor: UIColor {
        isFavorite ? .systemOrange : .white
    }

    var favoriteCountText: String {
        return "\(teacher.favoriteCount ?? 0)"
    }

    var teacherCoinText: String {
        return "\(teacher.teacherReserveCoin ?? 0)"
    }

}
