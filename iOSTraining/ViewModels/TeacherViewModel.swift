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

    var cancellables = Set<AnyCancellable>()

    init(teacher: Teacher) {
        self.teacher = teacher
    }

    func toggleFavorite() {
        teacher.isFavorited.toggle()
        print("image tapped")
        if teacher.isFavorited {
            teacher.favoriteCount = (teacher.favoriteCount ?? 0) + 1
        } else {
            teacher.favoriteCount = max((teacher.favoriteCount ?? 0) - 1, 0)
        }
    }

    func reserveTeacher() {
        var reserved = ReservedTeacherManager.shared.getReservedTeachers()
        reserved.append(teacher)
        ReservedTeacherManager.shared.save(reserved)
    }

    var favoriteImageName: String {
        return teacher.isFavorited ? "heart.fill" : "heart"
    }

    var favoriteTintColor: UIColor {
        return teacher.isFavorited ? .systemOrange : .white
    }

    var favoriteCountText: String {
        return "\(teacher.favoriteCount ?? 0)"
    }

    var teacherCoinText: String {
        return "\(teacher.teacherReserveCoin ?? 0)"
    }
}
