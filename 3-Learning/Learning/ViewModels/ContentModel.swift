//
//  ContentModel.swift
//  Learning
//
//  Created by Jacob Summerville on 9/17/22.
//

import Foundation

class ContentModel: ObservableObject {
    @Published var modules = [Module]()
    
    // current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    // current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // current lesson explanation
    @Published var codeText = NSAttributedString()
    var styleData: Data?
    
    // current selected content and test
    @Published var currentContentSelected:Int?
    @Published var currentTestSelected:Int?
    
    // current question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    init() {
        getLocalData()
        getRemoteData()
    }
    
    // MARK: - Data Methods
    
    func getLocalData() {
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
       
            self.modules = modules
        } catch {
            print("Couldn't parse local JSON data")
        }
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData
        } catch {
            print("Couldn't parse the style data")
        }
    }
    
    func getRemoteData() {
        let urlString = "https://jsummer10.github.io/iOS-Apps/docs/data/3-learning-data.json"
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            // couldn't create url
            print("Couldn't create URL")
            return
        }
        
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print("Couldn't create DataTask")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let modules = try decoder.decode([Module].self, from: data!)
                self.modules += modules
                print(modules)
            } catch {
                
            }
        }
        
        dataTask.resume()
    }
    
    // MARK: - Module navigation methods
    
    func beginModule(_ moduleid:Int) {
        // find the index for this module id
        for index in 0..<modules.count {
            if modules[index].id == moduleid {
                currentModuleIndex = index
                break
            }
        }
        
        currentModule = modules[currentModuleIndex]
    }
    
    func beginLesson(_ lessonIndex:Int) {
        // find the index for this lesson id
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        } else {
            currentLessonIndex = 0
        }
        
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        codeText = addStyling(currentLesson!.explanation)
    }
    
    func hasNextLesson() -> Bool {
        return currentLessonIndex + 1 < currentModule!.content.lessons.count
    }
    
    func beginTest(_ moduleId:Int) {
        beginModule(moduleId)
        
        // set the current question
        currentQuestionIndex = 0
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
    }
    
    func nextLesson() {
        currentLessonIndex += 1
        
        // verify next lesson is in range
        if currentLessonIndex < currentModule!.content.lessons.count {
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)
        } else {
            // reset lesson state
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1
        
        // verify next lesson is in range
        if currentQuestionIndex < currentModule!.test.questions.count {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        } else {
            // reset lesson state
            currentQuestionIndex = 0
            currentQuestion = nil
        }
    }
    
    // MARK: - Code Styling
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
        
        // add styling data
        if styleData != nil {
            data.append(styleData!)
        }
        
        // add html data
        data.append(Data(htmlString.utf8))
        
        // convert to attributed string
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            resultString = attributedString
        }
        
        return resultString
    }
}
