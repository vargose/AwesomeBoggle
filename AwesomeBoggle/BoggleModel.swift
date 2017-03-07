import Foundation

protocol BoggleModelProtocol: class {
    func currentWordUpdated(currentWord: String)
    func wordListUpdated(wordList: [String])
}

class BoggleModel {
    weak var delegate: BoggleModelProtocol?
    
    var dictionaryService = DictionaryService()

    var currentWord: String = ""
    private var wordList: [String] = []
    
    init(dictionaryService: DictionaryService = DictionaryService()){
        self.dictionaryService = dictionaryService
    }
    
    func randomLetter() -> String {
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
    
    func addLetterToCurrentWord(letter: String){
        currentWord.append(letter);
        self.delegate?.currentWordUpdated(currentWord: currentWord)
    }
    
    func submitWord(){
        self.dictionaryService.checkValidityOf(word: currentWord) { (theWord, isValid) in
            self.wordList.append(theWord)
            self.delegate?.wordListUpdated(wordList: self.wordList)
        }
        currentWord = ""
        self.delegate?.currentWordUpdated(currentWord: currentWord)
        
    }
    
    func reset(){
        self.wordList.removeAll()
    }
    
}
