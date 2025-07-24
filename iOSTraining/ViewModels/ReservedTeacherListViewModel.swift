//
//  ReservedTeacherListViewModel.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/24/25.
//

import Foundation

class ReservedTeacherListViewModel: ObservableObject {
    @Published var reservedTeacherViewModels: [TeacherViewModel] = []
    @Published var totalReservedCoin: Int = 0

    init() {
        load()
    }

    func load() {
        let reserved = ReservedTeacherManager.shared.getReservedTeachers()
        reservedTeacherViewModels = reserved.map { TeacherViewModel(teacher: $0) }
        totalReservedCoin = ReservedTeacherManager.shared.getTotalReservedCoin()
    }

    func refresh() {
        load()
    }
}
