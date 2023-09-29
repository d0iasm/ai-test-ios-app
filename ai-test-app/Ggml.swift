//
//  Ggml.swift
//  ai-test-app
//
//  Created by Asami Doi on 25/08/2023.
//

import Foundation

func executeGpt2() -> String {
    let task = NSTask.init()
    
    let fileManager = FileManager.default
    let path = FileManager.default.currentDirectoryPath
    let bundlePath = Bundle.main
    let resourcePath = Bundle.main.resourcePath!
    print(fileManager)
    print(path)
    print(bundlePath)
    print(resourcePath)
    
    task?.setLaunchPath("/Users/asamidoi/ai_research/ggml/build/bin/gpt-2")
    //task?.setLaunchPath(basePath + "/gpt-2")
    
    task?.arguments = ["-m", "/Users/asamidoi/ai_research/ggml/build/models/gpt-2-117M/ggml-model.bin", "-p", "Summarize the word 'machine learning' within 200 words"]
    //task?.arguments = ["-m", "/Users/asamidoi/ai_research/ggml/build/models/gpt-2-117M/ggml-model.bin", "-p", "Visit the page user provides and summarize the page within 200 words"]
    //task?.arguments = ["-m", basePath + "/ggml-model.bin", "-p", "Summarize the word of 'Large Language Model' within 200 words"]
    
    // Create a Pipe and make the task
    // put all the output there
    let pipe = Pipe()
    let errorPipe = Pipe()
    task?.standardOutput = pipe
    task?.standardError = errorPipe
    
    // Launch the task
    task?.launch()
    task?.waitUntilExit()
    
    // Get the data
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
    
    return output! as String
}
