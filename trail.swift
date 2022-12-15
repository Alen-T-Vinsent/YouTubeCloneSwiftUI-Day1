
import SwiftUI
//
//struct ContentViedw: View {
//    var body: some View {
//            ScrollView {
//                ZStack {
//                    LazyVStack {
//                        ForEach(0...100, id: \.self) { index in
//                            Text("Row \(index)")
//                        }
//                    }
//                    GeometryReader { proxy in
//                        let offset = proxy.frame(in: .named("scroll")).minY
//                        Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
//                    }
//                }
//            }
//            .coordinateSpace(name: "scroll")
//            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
//                print(value)
//            }
//    }
//}


struct DemoScrollViewOffsetView: View {
    @State private var offset = CGFloat.zero
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<100) { i in
                    Text("Item \(i)").padding()
                }
            }.background(GeometryReader {
                Color.clear.preference(key: ViewOffsetKey.self,
                    value: -$0.frame(in: .named("scroll")).origin.y)
                
                
                
            })
            .onPreferenceChange(ViewOffsetKey.self) { print("offset >> \($0)") }
        }.coordinateSpace(name: "scroll")
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
