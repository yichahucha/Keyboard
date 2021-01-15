//
//  KeyboardView.swift
//  Keyboard
//
//  Created by goose on 2021/1/15.
//


let grey = Color(red: 171/255, green: 174/255, blue: 177/255)
let grey1 = Color(red: 161/255, green: 161/255, blue: 166/255)
let sliver = Color(red: 221/255, green: 223/255, blue: 222/255)

let macBookColor = sliver
let keyboardColor = grey
let touchColor = keyboardColor

let keySide: CGFloat = 50.0
let keySapcing: CGFloat = 10.0
let touchWidth: CGFloat = 6 * keySide + 5 * keySapcing
let touchHeight: CGFloat = 4 * keySide + 3 * keySapcing
let macBookWidth: CGFloat = 16 * keySide + 17 * keySapcing
let macBookHeight: CGFloat = 11 * keySide + 12 * keySapcing
let keyboardWidth: CGFloat = 14 * keySide + 13 * keySapcing
let keyboardHeight: CGFloat = 5.5 * keySide + 5 * keySapcing

let keyss = [
    ["esc","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","􀆨"],
    ["~","1","2","3","4","5","6","7","8","9","0","-","+","delete"],
    ["tab","Q","W","E","R","T","Y","U","I","O","P","{","}","|"],
    ["􀆡","A","S","D","F","G","H","J","K","L",":","\"","return"],
    ["shift","Z","X","C","V","B","N","M","<",">","􀅍","shift"],
    ["fn","control","option","􀆔","","􀆔","option","􀄦","􀄤􀄥","􀄧"]
]

import SwiftUI

struct KeyboardView: View {
    var body: some View {
        VStack {
            /// 按键区域
            VStack(alignment: .leading, spacing: keySapcing) {
                ForEach(0 ..< keyss.count) { m in
                    HStack(spacing: keySapcing - 1) {
                        let keys = keyss[m]
                        ForEach(0 ..< keys.count) { n in
                            let end = keys.endIndex - 1
                            let key = keys[n]
                            switch (m, n) {
                            case (0, _):
                                KeyButton(text: key, height: keySide / 2)
                            case (1, end),
                                 (2, 0),
                                 (3, 0), (3, end),
                                 (4, 0), (4, end),
                                 (5, 4):
                                KeyButton(text: key, height: keySide, width: keySide - 2)
                                    .layoutPriority(1.0)
                            case (5, end), (5, end - 2):
                                VStack {
                                    Spacer()
                                    KeyButton(text: key, height: keySide / 2)
                                }
                            case (5, end - 1):
                                VStack(spacing: 0.5) {
                                    KeyButton(text: String(key.prefix(1)), height: keySide / 2)
                                    KeyButton(text: String(key.suffix(1)), height: keySide / 2)
                                }
                            case (_, _):
                                KeyButton(text: key, height: keySide - 2, width: keySide - 2)
                            }
                        }
                    }
                }
            }
            .frame(width: keyboardWidth, height: keyboardHeight)
            .padding(.all, 10.0)
            .background(keyboardColor)
            .cornerRadius(10.0)
            
            /// 触摸区域
            touchColor
                .frame(width: touchWidth, height: touchHeight, alignment: .center)
                .cornerRadius(10.0)
                .offset(y:15.0)
        }
        .frame(width: macBookWidth,height: macBookHeight)
        .background(macBookColor)
        .cornerRadius(30.0)
    }
}

struct KeyButton: View {
    var text: String
    var height: CGFloat = keySide
    var width: CGFloat = keySide
    var body: some View {
        GeometryReader { geometry in
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 13.0))
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .frame(minWidth: width, maxWidth: .infinity, minHeight: height, maxHeight: height)
        .background(Color(.black))
        .cornerRadius(6.0)
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
            .previewLayout(.sizeThatFits)
    }
}
