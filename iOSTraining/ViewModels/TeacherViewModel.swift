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
    @Published var isFavorite: Bool = false

    var cancellables = Set<AnyCancellable>()

    init(teacher: Teacher) {
        self.teacher = teacher
        self.teacher.isFavorite = UserDefaults.standard
            .isFavorite(id: teacher.id ?? 0)
    }

    func toggleFavorite() {
        UserDefaults.standard.toggleFavorite(id: teacher.id ?? 0)
        teacher.isFavorite.toggle()
        print("heart tapped")
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
    }

    var favoriteImageName: String {
        return teacher.isFavorite ? "heart.fill" : "heart"
    }

    var favoriteTintColor: UIColor {
        return teacher.isFavorite ? .systemOrange : .white
    }

    var favoriteCountText: String {
        return "\(teacher.favoriteCount ?? 0)"
    }

    var teacherCoinText: String {
        return "\(teacher.teacherReserveCoin ?? 0)"
    }

}
