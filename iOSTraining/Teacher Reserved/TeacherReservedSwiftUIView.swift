//
//  TeacherReservedSwiftUIView.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/21/25.
//

import SwiftUI

struct TeacherReservedSwiftUIView: View {
    @ObservedObject var viewModel: ReservedTeacherListViewModel

    var body: some View {
        VStack(spacing: 4){
            HStack(alignment: .center){
                Text("Reserved Teachers")
                    .font(.headline)
                    .fontWeight(.semibold)
            }

            HStack {
                Text("Total")
                    .font(.subheadline)
                IconWithTextView(systemImageName: "coin", label: ": \(viewModel.totalReservedCoin)")
            }

            List(viewModel.reservedTeacherViewModels, id: \.teacher.id) { teacherVM in
                HStack {
                    AsyncImage(url: URL(string: teacherVM.teacher.imageMain ?? "")) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                    } placeholder: {
                        Color.gray
                    }

                    VStack(alignment: .leading) {
                        Text(teacherVM.teacher.nameEng ?? "Unknown")
                        IconWithTextView(systemImageName: "coin", label: "\(teacherVM.teacher.teacherReserveCoin ?? 0)")

//                        ReserveButtonView(viewModel: teacherVM)
//                            .onChange(of: teacherVM.isReserved) { _ in
//                                viewModel.refresh()
//                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.refresh()
        }
    }
}


//#Preview {
//    TeacherReservedSwiftUIView()
//}
