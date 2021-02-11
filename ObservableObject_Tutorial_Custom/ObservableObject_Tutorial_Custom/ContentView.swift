//
//  ContentView.swift
//  ObservableObject_Tutorial_Custom
//
//  Created by apple on 2021/02/07.
//

import SwiftUI

struct MemoData: Hashable { // 텍스트 내용과 적었던 시간을 담아줄 내용 Hashable은 구조체를 데이터로 저장하고 있기 때문에 강제적으로 사용해야하는 프로토콜이다

    var content = ""
    var date = Date()
}

class MyMemoViewModel: ObservableObject { // MemoData를 담을 모델
    @Published var list: [MemoData] = []
}

struct ContentView: View {
    @State var memoData = MemoData() // 두가지 값을 받을 변수를 선언
    @ObservedObject var memoView = MyMemoViewModel() //memoData를 받아 뿌려줄 모델
    
    var body: some View {
        VStack() {
            HStack {
                TextField("리스트에 추가할 글자를 입력해주세요", text: $memoData.content)
                    .padding()
                
                CreateButton(textField: $memoData, model: memoView) // 추가하기 버튼 클릭시 데이터 업데이트 (변화된 memoData의 값과 model을 같이 보냄)
            }
            
            List {
                ForEach(memoView.list, id: \.self) { item in // memoView안의 list변수에 있는 값을 하나씩 item에 넣어준다
                    HStack(spacing: 0) {
                        Text(item.content)
                            .padding(0)
                            .background(Color.blue)
                        Spacer()
                        Text(item.date, style: .date)
                            .padding(10)
                    }
                }
            }
            
        }
    }
}

struct CreateButton: View {
    @Binding var textField: MemoData // memoData 값을 받아옴
    var model: MyMemoViewModel // model 값을 받아옴
        
    var body: some View {
        
        Button(action: {
            self.model.list.append(textField) //리스트에 추가해준다. MyMemoViewModel은 ObservableObject 프로토콜이기때문에 값이 변하면 다시 뷰를 업데이트함 -> 추가버튼 클릭시 화면 리스트에 입력했던 memo가 추가로 출력됨
        }, label: {
            Text("추가하기")
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
        })
        .padding(.horizontal)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
