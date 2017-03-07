import UIKit

protocol BoggleViewProtocol: class {
    func buttonPressedWithLetter(_ letter: String)
    func resetTapped()
    func enterTapped()
    func wordTapped(word: BoggleWord)
}

class BoggleView: UIView, UITableViewDelegate, UITableViewDataSource {
    weak var delegate: BoggleViewProtocol?
    var currentWordLabel = UILabel()
    private var buttonArray: [UIButton] = []
    var buttonCount: Int {
        get {
            return buttonArray.count
        }
    }
    var wordList: [String]=[]
    private var wordListTableView = UITableView()

    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .gray
        
        let resetButton = UIButton()
        resetButton.setTitle("Reset", for: .normal)
        resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
        
        self.addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        resetButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        self.addSubview(verticalStackView);
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 20).isActive = true
        verticalStackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        for _ in 0...3 {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            verticalStackView.addArrangedSubview(stackView)
            
            stackView.backgroundColor = .white
            
            for index in 0...3 {
                let buttonToAdd = UIButton()
                stackView.addArrangedSubview(buttonToAdd)
                buttonArray.append(buttonToAdd)
                buttonToAdd.translatesAutoresizingMaskIntoConstraints = false
                buttonToAdd.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1/4).isActive = true
                buttonToAdd.heightAnchor.constraint(equalTo: buttonToAdd.widthAnchor).isActive = true
                buttonToAdd.backgroundColor = .white
                buttonToAdd.setTitleColor(.purple, for: .normal)
                buttonToAdd.layer.borderColor = UIColor.red.cgColor
                buttonToAdd.layer.borderWidth = 1
                buttonToAdd.layer.cornerRadius = 10
                
                buttonToAdd.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                
            }
        }
        
        self.addSubview(currentWordLabel)
        currentWordLabel.translatesAutoresizingMaskIntoConstraints = false
        currentWordLabel.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 10).isActive = true
        currentWordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        currentWordLabel.backgroundColor = .white
        currentWordLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        currentWordLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2/3).isActive = true
        currentWordLabel.isAccessibilityElement = true
        
        let enterButton = UIButton()
        self.addSubview(enterButton)
        enterButton.setTitle("Enter", for: .normal)
        enterButton.setTitleColor(.black, for: .normal)
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        enterButton.topAnchor.constraint(equalTo: currentWordLabel.topAnchor).isActive = true
        enterButton.leadingAnchor.constraint(equalTo: currentWordLabel.trailingAnchor, constant: 10).isActive = true
        enterButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        

        wordListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "wordcell")
        wordListTableView.delegate = self
        wordListTableView.dataSource = self
        
        self.addSubview(wordListTableView)
        wordListTableView.translatesAutoresizingMaskIntoConstraints = false
        wordListTableView.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 10).isActive = true
        wordListTableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        wordListTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func buttonTapped(sender: UIButton){
        let letter = sender.titleLabel?.text
        if let letter = letter {
            self.delegate?.buttonPressedWithLetter(letter)
        }
    }
    
    @objc
    private func resetTapped() {
        self.delegate?.resetTapped()
    }

    
    @objc
    func enterButtonTapped(sender: UIButton){
        self.delegate?.enterTapped()
        
    }
    
    func reset() {
        self.wordList.removeAll()
        self.wordListTableView.reloadData()
    }
    
    func setCurrentWord(_ currentWord: String){
        currentWordLabel.text = currentWord
    }
    
    func setButtonTitles(_ buttonTitles: [String]) {
        var int = 0
        for button in buttonArray {
            button.setTitle(buttonTitles[int], for: .normal)
            int += 1
        }
    }
    
    func updateWordList(_ wordList: [String]) {
        self.wordList = wordList
        self.wordListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordcell", for: indexPath)
        cell.textLabel?.text = wordList[indexPath.row]
        return cell
    }
    

    
    

    
}
