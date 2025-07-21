//
//  TeacherReservedSwiftUIView.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/21/25.
//

import SwiftUI

struct TeacherReservedSwiftUIView: View {
    let reservedTeachers: [Teacher]
    let totalReservedCoin: Int

    var body: some View {
        VStack {
            Text("Total Coins: \(totalReservedCoin)")

            List(reservedTeachers, id: \.id) { teacher in
                VStack(alignment: .leading) {
                    Text(teacher.nameEng ?? "Unknown")
                    Text("Coins: \(teacher.teacherReserveCoin ?? 0)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Reserved Teachers")
    }
}

//#Preview {
//    TeacherReservedSwiftUIView()
//}
