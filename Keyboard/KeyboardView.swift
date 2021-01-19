//
//  KeyboardView.swift
//  Keyboard
//
//  Created by goose on 2021/1/15.
//

import SwiftUI


struct Keyboard {
    enum Key {
        enum Alignment {
            case left
            case right
        }
        case alphabet(String)
        case symbol(String, String)
        case function(String, String)
        case side(String, String, Alignment)
        case arrow(String)
        case upDownArrow(String, String)
        case option(String, String, Alignment)
        case command(String, String, Alignment)
        case space
        case fn(String)
        case control(String)
    }
    
    static let grey = Color(red: 171/255, green: 174/255, blue: 177/255)
    static let grey1 = Color(red: 161/255, green: 161/255, blue: 166/255)
    static let sliver = Color(red: 221/255, green: 223/255, blue: 222/255)

    static let keySide: CGFloat = 55.5
    static let keySapcing: CGFloat = 10
    static let touchWidth: CGFloat = 6 * keySide
    static let touchHeight: CGFloat = 4 * keySide + 3 * keySapcing
    static let macBookWidth: CGFloat = 16 * keySide + 17 * keySapcing
    static let macBookHeight: CGFloat = 11 * keySide + 12 * keySapcing
    static let keyboardWidth: CGFloat = 14 * keySide + 13 * keySapcing
    static let keyboardHeight: CGFloat = 5.5 * keySide + 5 * keySapcing
    
    static let keyss:[[Keyboard.Key]] = [
        [.function("esc", ""),
         .function("F1", "sun.min"),
         .function("F2", "sun.max"),
         .function("F3", "rectangle.3.offgrid"),
         .function("F4", "square.grid.3x2"),
         .function("F5", "light.min"),
         .function("F6", "light.max"),
         .function("F7", "backward.fill"),
         .function("F8", "playpause.fill"),
         .function("F9", "forward.fill"),
         .function("F10", "speaker.fill"),
         .function("F11", "speaker.wave.2.fill"),
         .function("F12", "speaker.wave.3.fill"),
         .function("", "power")],
        [.symbol("~", "`"),
         .symbol("!", "1"),
         .symbol("@", "2"),
         .symbol("#", "3"),
         .symbol("$", "4"),
         .symbol("%", "5"),
         .symbol("^", "6"),
         .symbol("&", "7"),
         .symbol("*", "8"),
         .symbol("(", "9"),
         .symbol(")", "0"),
         .symbol("—", "-"),
         .symbol("+", "="),
         .side("delete", "", .right)],
        [.side("tab", "", .left),
         .alphabet("Q"),
         .alphabet("W"),
         .alphabet("E"),
         .alphabet("R"),
         .alphabet("T"),
         .alphabet("Y"),
         .alphabet("U"),
         .alphabet("I"),
         .alphabet("O"),
         .alphabet("P"),
         .symbol("[", "{"),
         .symbol("]", "}"),
         .symbol("\\", "|")],
        [.side("caps lock", "・", .left),
         .alphabet("A"),
         .alphabet("S"),
         .alphabet("D"),
         .alphabet("F"),
         .alphabet("G"),
         .alphabet("H"),
         .alphabet("J"),
         .alphabet("K"),
         .alphabet("L"),
         .symbol(":", ";"),
         .symbol("\"", "'"),
         .side("return", "enter", .right)],
        [.side("shift", "", .left),
         .alphabet("Z"),
         .alphabet("X"),
         .alphabet("C"),
         .alphabet("V"),
         .alphabet("B"),
         .alphabet("N"),
         .alphabet("M"),
         .symbol("<", ","),
         .symbol(">", "."),
         .symbol("?", "/"),
         .side("shift", "", .right)],
        [.fn("fn"),
         .control("control"),
         .option("option", "alt", .left),
         .command("command", "command", .left),
         .space,
         .command("command", "command", .right),
         .option("option", "alt", .right),
         .arrow("arrowtriangle.left.fill"),
         .upDownArrow("arrowtriangle.up.fill","arrowtriangle.down.fill"),
         .arrow("arrowtriangle.right.fill")]
    ]
}

struct KeyboardView: View {
    var body: some View {
        VStack {
            /// 按键区域
            VStack(alignment: .leading, spacing: Keyboard.keySapcing) {
                ForEach(0 ..< Keyboard.keyss.count) { i in
                    HStack(spacing: Keyboard.keySapcing) {
                        let keys = Keyboard.keyss[i]
                        ForEach(0 ..< keys.count) { j in
                            KeyView(key: keys[j])
                        }
                    }
                }
            }
            .frame(width: Keyboard.keyboardWidth, height: Keyboard.keyboardHeight)
            .padding(15)
            .background(Keyboard.grey)
            .cornerRadius(10.0)
            
            /// 触摸区域
            Keyboard.sliver
                .frame(width: Keyboard.touchWidth, height: Keyboard.touchHeight, alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(Keyboard.grey, lineWidth: 1))
                .offset(y:18.0)
        }
        .frame(width: Keyboard.macBookWidth,height: Keyboard.macBookHeight)
        .background(Keyboard.sliver)
        .cornerRadius(30.0)
    }
}


struct KeyView: View {
    var key: Keyboard.Key
    var body: some View {
        switch key {
        case .alphabet(let text):
            KeyButton {
                Text(text)
            }
        case .function(let text, let image):
            KeyButton(height: Keyboard.keySide / 2) {
                ZStack(alignment: .center) {
                    if !image.isEmpty {
                        Image(systemName: image)
                            .font(.system(size: 10.0))
                    }
                    if image.isEmpty {
                        Text(text)
                            .font(.system(size: 10.0))
                    }else {
                        Text(text)
                            .font(.system(size: 6.0))
                            .offset(x: 17, y: 5)
                    }
                }
            }
        case .symbol(let text, let text1):
            KeyButton {
                VStack {
                    Text(text)
                    Text(text1)
                }
            }
        case .side(let t, let t1, let p):
            KeyButton {
                VStack(alignment: p == .left ? .leading : .trailing) {
                    Text(t1)
                        .font(.system(size: 8.0))
                    Spacer()
                        .frame(height: 18)
                    Text(t)
                        .font(.system(size: 10.0))
                }
                .alignment(p)
            }
            .layoutPriority(1)
        case .arrow(let image):
            VStack {
                Spacer()
                KeyButton(height: Keyboard.keySide / 2) {
                    Image(systemName: image)
                        .font(.system(size: 10.0))
                }
            }
        case .upDownArrow(let image, let image1):
            VStack(spacing: 0.5) {
                KeyButton(height: Keyboard.keySide / 2) {
                    Image(systemName: image)
                }
                KeyButton(height: Keyboard.keySide / 2) {
                    Image(systemName: image1)
                }
            }
            .font(.system(size: 10.0))
        case .space:
            KeyButton {
                Spacer()
            }
            .layoutPriority(1)
        case .command(let t, let i, let p):
            KeyButton(width: Keyboard.keySide + 13) {
                VStack(alignment: p == .right ? .leading : .trailing) {
                    Image(systemName: i)
                        .font(.system(size: 10.0))
                    Spacer()
                        .frame(height: 18)
                    Text(t)
                        .font(.system(size: 10.0))
                }
            }
        case .option(let t, let i, let p):
            KeyButton(width: Keyboard.keySide - 1.5) {
                VStack(alignment: p == .left ? .leading : .trailing) {
                    Text(i)
                        .font(.system(size: 8.0))
                    Spacer()
                        .frame(height: 18)
                    Text(t)
                        .font(.system(size: 10.0))
                }
                .alignment(p)
            }
        case .fn(let t), .control(let t):
            KeyButton(width: Keyboard.keySide - 1.5) {
                VStack {
                    Text("")
                        .font(.system(size: 8.0))
                    Spacer()
                        .frame(height: 18)
                    Text(t)
                        .font(.system(size: 10.0))
                }
                .alignment(.left)
            }
        }
    }
}

extension View {
    func alignment(_ p: Keyboard.Key.Alignment) -> some View {
        HStack {
            if p == .right {Spacer()}
            if p == .left {Spacer().frame(width: 8)}
            self
            if p == .left {Spacer()}
            if p == .right {Spacer().frame(width: 8)}
            
        }
    }
}

struct KeyButton<Label>: View where Label: View{
    var height: CGFloat = Keyboard.keySide
    var width: CGFloat = Keyboard.keySide
    var label: () -> Label
    var action: () -> Void = {}
    var body: some View {
        Button(action: {
            action()
        }, label: {
            label().foregroundColor(.white)
        })
        .frame(minWidth: width - 1.5, maxWidth: .infinity, minHeight: height - 1.5, maxHeight: height)
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
