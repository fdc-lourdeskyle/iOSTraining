//
//  TeacherListViewModel.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/22/25.
//

import Foundation
import Combine

class TeacherListViewModel: ObservableObject {
    @Published var teachers : [TeacherViewModel] = []

    var cancellables = Set<AnyCancellable>()

    init(teachers: [Teacher]) {
        self.teachers = teachers.map { TeacherViewModel(teacher: $0) }
    }

    func refreshFavorites() {
        for vm in teachers {
            vm.teacher.isFavorite = UserDefaults.standard.isFavorite(id: vm.teacher.id ?? 0)
        }
    }

}
