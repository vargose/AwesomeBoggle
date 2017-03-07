import UIKit

class BoggleViewController: UIViewController {
    
    let boggleView: BoggleView
    let boggleModel: BoggleModel
    
    init(boggleView: BoggleView = BoggleView(), boggleModel: BoggleModel = BoggleModel()) {
        self.boggleView = boggleView
        self.boggleModel = boggleModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = boggleView
        self.boggleView.delegate = self
        self.boggleModel.delegate = self
        self.resetTapped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BoggleViewController: BoggleViewProtocol {
    func buttonPressedWithLetter(_ letter: String) {
        boggleModel.addLetterToCurrentWord(letter: letter)
    }
    
    func resetTapped() {
        let numberOfButtons = boggleView.buttonCount
        let newButtonTitles = boggleModel.lettersArray(numberOfLetters: numberOfButtons)
        boggleView.setButtonTitles(newButtonTitles)
    }
    
    func enterTapped() {
        self.boggleModel.submitWord()
    }
    
    func wordTapped(word: BoggleWord) {
        self.navigationController?.pushViewController(WordDetailViewController(), animated: true)
    }
}

extension BoggleViewController: BoggleModelProtocol {
    func currentWordUpdated(currentWord: String) {
        self.boggleView.setCurrentWord(currentWord)
    }
    
    func wordListUpdated(wordList: [BoggleWord]) {
        DispatchQueue.main.async {
            self.boggleView.updateWordList(wordList)
        }
    }
    
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
}

