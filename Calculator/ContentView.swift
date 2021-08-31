//
//  ContentView.swift
//  Calculator
//
//  Created by Walter yun on 2021/08/30.
//

import SwiftUI

//열거
enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case mutliply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "+/-"

    //버튼 색상
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .mutliply, .divide, .equal:
            //오랜지 색상으로 return
            return .orange
        case.clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}
//연산
enum Operation {
    case add, subtract, multiply, divide, equal, none
}

struct ContentView: View {
    
    @State var value = "0"
    
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .mutliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],

    ]
    
    var body: some View {
        //Zstack은 뷰를 겹쳐서 표현할때 사용하게됨
        ZStack {
            
            //safearea까지 추가하기
            Color.black.edgesIgnoringSafeArea(.all)
            
            //수직으로 view를 쌓는 스텍
            VStack {
                Spacer()
                // text 화면
                //View를 가로로 정렬
                HStack {
                    //텍스트를 가장 오른쪽까지 이동
                     Spacer()
                    Text(value)
                        .foregroundColor(.white)
                        .font(.system(size: 100
                        ))
                        .bold()
                }
                .padding()
                
                
                ForEach(buttons, id: \.self) { row in
                    //HStack 가로로
                    HStack(spacing: 12) {
                    ForEach(row, id: \.self) { item in
                        Button(action: {
                            //버튼을 클릭했을때 적용
                            self.didTap(button: item)
                        }, label: {
                            Text(item.rawValue)
                                //버튼 크기 조절
                                .frame(
                                    width: self.buttonWidth(item: item),
                                    height: self.buttonHeight()
                                )
                                .background(item.buttonColor)
                                .foregroundColor(.white)
                                //코너지름값
                                .cornerRadius(self.buttonWidth(item: item)/2)
                                //패딩
                                //.padding()
                                .font(.system(size: 32))
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    //button 클릭 이벤트
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .mutliply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
            }

        case .clear:
            self.value = "0"
            break
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            //가장 하단줄 정렬
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
