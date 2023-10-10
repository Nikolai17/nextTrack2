//
//  ContentView.swift
//  NextTrack2
//
//  Created by Nikolay Volnikov on 10.10.2023.
//

import SwiftUI

struct ContentView: View {

    @State private var isAnimated1 = false
    @State private var isAnimated2 = false

    var body: some View {
        HStack(spacing: 50) {
            VStack(spacing: 40) {
                Button {
                    withAnimation((.spring(dampingFraction: 0.5, blendDuration: Constants.duration1))) {
                        isAnimated1.toggle()

                        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.duration1) {
                            isAnimated1.toggle()
                        }
                    }
                } label: {
                    HStack(spacing: 0) {
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(
                                width: isAnimated1 ? 40 : 0,
                                height: isAnimated1 ? 40 : 0
                            )
                            .opacity(isAnimated1 ? 1 : .zero)
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(
                                width: 40,
                                height: 40
                            )

                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(
                                width: isAnimated1 ? .zero : 40,
                                height: isAnimated1 ? .zero : 40
                            )
                            .opacity(isAnimated1 ? 0 : 1)
                    }
                }
                .frame(width: 80, height: 40)
                .buttonStyle(MyButtonStyle1())
                .foregroundColor(.blue)

                Group {
                    Text("Scale: 0.86 \nDuration: \(Constants.duration2.formatted())")
                }
            }


            VStack(spacing: 40) {
                Button {
                    withAnimation((.spring(dampingFraction: 0.5, blendDuration: Constants.duration2))) {
                        isAnimated2.toggle()

                        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.duration2) {
                            isAnimated2.toggle()
                        }
                    }
                } label: {
                    HStack(spacing: 0) {
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(
                                width: isAnimated2 ? 40 : 0,
                                height: isAnimated2 ? 40 : 0
                            )
                            .opacity(isAnimated2 ? 1 : .zero)
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(
                                width: 40,
                                height: 40
                            )

                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(
                                width: isAnimated2 ? .zero : 40,
                                height: isAnimated2 ? .zero : 40
                            )
                            .opacity(isAnimated2 ? 0 : 1)
                    }
                }
                .frame(width: 80, height: 40)
                .buttonStyle(MyButtonStyle2())
                .foregroundColor(.blue)

                Group {
                    Text("Scale: 0 \nDuration: \(Constants.duration1.formatted())")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MyButtonStyle1: ButtonStyle {
    @State private var isTapped: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 80, height: 80)
            .padding(.all, 15)
            .background(configuration.isPressed ? .gray.opacity(0.3) : .white)
            .clipShape(Circle())
            .onChange(of: configuration.isPressed) { _ in
                isTapped = true

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
                    isTapped = false
                }
            }
            .scaleEffect(isTapped ? 0.86 : 1)
            .animation(.linear(duration: 0.22), value: isTapped)
    }
}

struct MyButtonStyle2: ButtonStyle {
    @State private var isTapped: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                Circle()
                .foregroundColor(.gray.opacity(isTapped ? 1 : .zero))
                .frame(width: 100, height: 100)
            )
            .onChange(of: configuration.isPressed) { _ in
                isTapped = true

                DispatchQueue.main.asyncAfter(deadline: .now() + Constants.duration1) {
                    isTapped = false
                }
            }
            .scaleEffect(isTapped ? 0 : 1)
            .animation(.linear(duration: Constants.duration1), value: isTapped)
    }
}

enum Constants {
    static let duration1 = 1.22
    static let duration2 = 0.22
}
