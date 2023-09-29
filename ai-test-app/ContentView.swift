//
//  ContentView.swift
//  ai-test-app
//
//  Created by Asami Doi on 25/08/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                
                /*
                Link("Wikipedia: Transformer", destination: URL(string: "https://en.wikipedia.org/wiki/Transformer_(machine_learning_model)")!).onLongPressGesture(perform: {
                   print("long pressed!")
                   print(executeGpt2())
                })
                
                Spacer()
                
                Link("Wikipedia: Transformer", destination: URL(string: "https://en.wikipedia.org/wiki/Transformer_(machine_learning_model)")!).onLongPressGesture(perform: {
                   print("long pressed!")
                })
                 */
                
                Spacer()
                
                Text("summarize the word of 'machine learning'").onLongPressGesture(perform: {
                   print("long pressed!")
                   print(executeGpt2())
                    //sendRequestToOpenAI(url: "https://en.wikipedia.org/wiki/Large_language_model22222")
                })
                
                Text("summarize the page of large language model").onLongPressGesture(perform: {
                    sendRequestToOpenAI(url: "https://en.wikipedia.org/wiki/Large_language_model")
                })
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
