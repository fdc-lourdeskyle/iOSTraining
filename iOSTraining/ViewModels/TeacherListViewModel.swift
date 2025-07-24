//
//  TeacherListViewModel.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/22/25.
//

import Foundation
import Combine

class TeacherListViewModel: ObservableObject {
    @Published var teachers: [TeacherViewModel] = []
    @Published var filteredTeachers: [TeacherViewModel] = []
    @Published var isSearching: Bool = false

    private var allTeachers: [TeacherViewModel] = []

    init(teachers: [Teacher]) {
        let viewModels = teachers.map { TeacherViewModel(teacher: $0) }
        self.teachers = viewModels
        self.filteredTeachers = viewModels
        self.allTeachers = viewModels
    }

    func refreshFavorites() {
        let favoriteIDs = UserDefaults.standard.favoriteTeacherIDs()

        for vm in teachers {
            vm.teacher.isFavorite = favoriteIDs.contains(vm.teacher.id ?? 0)
        }
    }

    func filter(by filter: String) {
        isSearching = false

        switch filter {
        case "Rating":
            filteredTeachers = allTeachers.sorted { ($0.teacher.rating ?? 0) > ($1.teacher.rating ?? 0) }

        case "Kids Rating":
            filteredTeachers = allTeachers.sorted { ($0.teacher.kidsRating ?? 0) > ($1.teacher.kidsRating ?? 0) }

        case "Lesson Count":
            filteredTeachers = allTeachers.sorted { ($0.teacher.lessons ?? 0) > ($1.teacher.lessons ?? 0) }

        case "Favorite Teachers":
            filteredTeachers = allTeachers.filter {
                UserDefaults.standard.isFavorite(id: $0.teacher.id ?? 0)
            }

        default:
            filteredTeachers = allTeachers
        }
    }

    func searchTeachers(keyword: String) {
        if keyword.trimmingCharacters(in: .whitespaces).isEmpty {
            isSearching = false
            filteredTeachers = allTeachers
        } else {
            isSearching = true
            filteredTeachers = allTeachers.filter {
                $0.teacher.nameEng?.localizedCaseInsensitiveContains(keyword) ?? false
            }
        }
    }
}
