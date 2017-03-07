import Foundation
import CoreData

protocol BoggleModelProtocol: class {
    func currentWordUpdated(currentWord: String)
    func wordListUpdated(wordList: [BoggleWord])
    func showAlert(message: String)
}

class BoggleModel {
    weak var delegate: BoggleModelProtocol?
    let dictionaryService: DictionaryService
    let coreDataManager: CoreDataManager
    
    init(dictionaryService:DictionaryService = DictionaryService(), coreDataManager: CoreDataManager = CoreDataManager()) {
        self.dictionaryService = dictionaryService
        self.coreDataManager = coreDataManager
    }
    
    private(set) var currentWord: String = ""
    private var wordList: [BoggleWord] = []
    
    private func randomLetter() -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let rand = Int(arc4random_uniform(26))
        let stringArray = Array(letters.characters)
        return String(stringArray[rand])
    }
    
    func lettersArray(numberOfLetters: Int) -> [String] {
        var array = [String]()
        for _ in 0..<numberOfLetters {
            array.append(randomLetter())
        }
        
        return array
    }
    
    func addLetterToCurrentWord(letter: String) {
        currentWord.append(letter)
        self.delegate?.currentWordUpdated(currentWord: currentWord)
    }
    
    func submitWord() {
        dictionaryService.checkValidityOf(word: currentWord) { (word, isValid) in
            if isValid {
                self.dictionaryService.getExampleSentence(for: word, callback: { (theWord, sentenceOptional) in
                    if let sentenceOptional = sentenceOptional {
                        let boggleWord = BoggleWord(word: theWord, exampleSentence: sentenceOptional)
                        self.coreDataManager.saveWord(text: theWord, definition: sentenceOptional)
                        let managedObjectWordList = self.coreDataManager.fetchWordList()
                        if let wordList = managedObjectWordList {
                            for word in wordList {
                                let realWord = word as! Word
                                let boggleWord = BoggleWord(word: realWord.text!, exampleSentence: realWord.description)
                            }
                        }
                        
                        
                        self.wordList.append(boggleWord)
                    }
                    
                    self.delegate?.wordListUpdated(wordList: self.wordList)
                })
            } else {
                self.delegate?.showAlert(message: "Not a real word")
            }
        }
        currentWord = ""
        self.delegate?.currentWordUpdated(currentWord: currentWord)
    }
    
}
