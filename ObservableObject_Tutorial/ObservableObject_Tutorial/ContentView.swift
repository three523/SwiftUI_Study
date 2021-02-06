//
//  ContentView.swift
//  ObservableObject_Tutorial
//
//  Created by apple on 2021/02/06.
//

import SwiftUI

class ObservableList: ObservableObject { // ObservableObject 프로토콜을 사용하여 Published 값이 바뀌면 뷰가 업데이트 되는 클래스를 만듦
    @Published var list: [String] = [] // 문자열을 받는 배열에 빈값을 넣어줌 이 값이 변하면 뷰가 업데이트 됨
}

struct ContentView: View {
    
    @State var text: String = "" // @State 는 간단한 변수 int,string,bool등 간단한 값을 저장하고 View의 현재 상태를 표시할때 사용(값이 바꼈는지)
    @ObservedObject var list = ObservableList() // ObservableObject의 프로토콜을 가진 클래스를 @ObservedObject로 정의한 변수에 저장하면 상태를 계속 확인하여 업데이트 해준다
    
    var body: some View { // 첫 화면
        VStack {
            Text(text) // text변수의 값이 없을경우 아무것도 입력이 안되고 밑에 TextField에 텍스트 입력시 @State이기 떄문에 입력한 값이 계속 뷰를 업데이트 시켜줌
            
            HStack {
                TextField("type text", text: $text) // $는 바인딩을 의미함 @Bindig은 다른 뷰를 연결할때 사용하고 $는 내 뷰와 연결할때 사용함. 내 뷰와 연결했기 때문에 텍스트의 값이 바뀌면 뷰가 계속 업데이트 됨
                
                CreateButton(text: $text, list: list) // ContentView 소유의 text를 $를 붙여서 연결하도록 CreateButton에 넘겨줌(소유권을 잠시 양도한다는 개념) CreateButton에서 text값을 바꾸면 ContentView의 뷰가 업데이트됨, ObservedObject 는 $를 사용할 필요가 없음
            }
            
            List(list.list, id: \.self) { item in // 리스트 내용들을 하나씩 뽑아 item 변수에 집어넣음
                Text(item)
            }
        }
    }
}

struct CreateButton: View {
    @Binding var text: String // @Binding으로 ContentView와 연결된 text변수를 받아서 CreateButton에 연결함
    var list: ObservableList // 똑같이 연결됨
    
    var body: some View {
        Button(action: {
            self.list.list.append(self.text) // 연결된 텍스트 값을 list에 추가
            self.text = "" // 텍스트를 리스트에 저장했으니 값을 초기화해준다.
        }, label: {
            Text("Create List")
        })
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
