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
        VStack(spacing: 4){
            HStack(alignment: .center){
                Text("Reserved Teachers")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            HStack{
                Text("Total")
                    .font(.subheadline)
                IconWithTextView(
                    systemImageName: "coin",
                    label: ": "+"\(totalReservedCoin)"
                )
            }

            List(reservedTeachers, id: \.id) { teacher in
                HStack{
                    AsyncImage(url: URL(string: teacher.imageMain ?? "")) { image in
                        image .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                    } placeholder: {
                        Color.gray
                    }
                    VStack(alignment: .leading) {
                        Text(teacher.nameEng ?? "Unknown")
                        IconWithTextView(systemImageName: "coin", label: "\(teacher.teacherReserveCoin ?? 0)")
                    }
                }
            }
        }
    }
}

//#Preview {
//    TeacherReservedSwiftUIView()
//}
