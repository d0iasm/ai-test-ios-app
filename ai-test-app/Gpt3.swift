//
//  Gpt3.swift
//  ai-test-app
//
//  Created by Asami Doi on 08/09/2023.
//

import Foundation

let OPENAI_URL: String = "https://api.openai.com/v1/chat/completions"
let OPENAI_API_KEY: String = "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"

func prompt(pageUrl: String) -> String {
    return """
{
    "model": "gpt-3.5-turbo",
    "messages": [
        {
            "role": "system",
            "content": "Visit the page user provides and summarize the page within 200 words"
        },
        {
            "role": "user",
            "content": "\(pageUrl)"
        }
    ]
}
"""
}

func convertToDictionary(from jsonString: String) -> [String: Any]? {
    guard let data = jsonString.data(using: .utf8) else {
        return nil
    }
    
    do {
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    } catch {
        print("Error converting to dictionary: \(error.localizedDescription)")
        return nil
    }
}

func sendRequestToOpenAI(url: String) {
    print("send a request to OpenAI API")
    
    let prompt = prompt(pageUrl: url)
    print("data: \(prompt)")
    
    let url = URL(string: OPENAI_URL)
    Task {
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.timeoutInterval = 15.0
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + OPENAI_API_KEY, forHTTPHeaderField: "Authorization")
        request.httpBody = prompt.data(using: .utf8)
        
        print("request is sending \(String(describing: request))")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        if let dataString = String(data: data, encoding: .utf8) {
            print("response data: \(dataString)")
            
            if let dictionary = convertToDictionary(from: dataString),
               let choices = dictionary["choices"] as? [[String: Any]],
               let result = choices.first?["message"] as? [String: Any],
               let text = result["content"] as? String {
                print("Text: \(text)")
            } else {
                print("failed to parse response data")
            }
        }
    }
}
