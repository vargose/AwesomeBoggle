//
//  BogelModelTest.swift
//  AwesomeBoggle
//
//  Created by mitch.harris on 2/9/17.
//  Copyright © 2017 mitch.harris. All rights reserved.
//
@testable import AwesomeBoggle
import XCTest

class BogelModelTest: XCTestCase {
    
    class MockBoggleModelDelegate : BoggleModelProtocol {
        
        var currentWordUpdatedCalled: Bool = false
        var wordListUpdatedCalled: Bool = false
        
        var latestCurrentWord = ""
        var latestWordList: [String] = []
        
        func currentWordUpdated(currentWord: String) {
            currentWordUpdatedCalled = true
            latestCurrentWord = currentWord
        }
        
        func wordListUpdated(wordList: [String]) {
            wordListUpdatedCalled = true
            latestWordList = wordList
        }
    }

    
    let testObject = BoggleModel()
    let mockDelegate = MockBoggleModelDelegate()
    
    override func setUp() {
        super.setUp()
        testObject.delegate = mockDelegate
    }

    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_addLetterToCurrentWord_addsLetter() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        testObject.addLetterToCurrentWord(letter: "h")
        
        XCTAssertEqual("h", testObject.currentWord)
        
    }
    
    func test_addLetterToCurrentWord_appendsSecondLetter() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        testObject.addLetterToCurrentWord(letter: "h")
        testObject.addLetterToCurrentWord(letter: "i")
        
        XCTAssertEqual("hi", testObject.currentWord)
        
    }
    
    func test_submitWord_clearsCurrentWord() {
        testObject.addLetterToCurrentWord(letter: "h")
        testObject.addLetterToCurrentWord(letter: "i")
        testObject.submitWord()
        
        XCTAssertEqual("", testObject.currentWord)
    }
    
    func test_lettersArray_returnsCorrectNumberOfLetters() {
        let result1 = testObject.lettersArray(numberOfLetters: 12)
        XCTAssertEqual(12, result1.count);
        
        let result2 = testObject.lettersArray(numberOfLetters: 1)
        XCTAssertEqual(result2.count, 1)
        
        let result3 = testObject.lettersArray(numberOfLetters: 124)
        XCTAssertEqual(result3.count, 124)
    }
    
    func test_lettersArray_returnsArrayOfCharacters() {
        
        let result1 = testObject.lettersArray(numberOfLetters: 1000)
        
        for char in result1 {
            XCTAssertTrue(NSCharacterSet.letters.contains(UnicodeScalar(char)!))
        }
    }

    //begin here
    func test_addLetterToCurrentWord_callsCurrentWordUpdatedOnDelegate() {
        testObject.addLetterToCurrentWord(letter: "h")
        
        XCTAssertTrue(mockDelegate.currentWordUpdatedCalled)
    }
    
    func test_addLetterToCurrentWord_sendsCorrectWordToDelegate() {
        
        testObject.addLetterToCurrentWord(letter: "h")
        XCTAssertEqual(mockDelegate.latestCurrentWord, "h")
        
        testObject.addLetterToCurrentWord(letter: "e")
        XCTAssertEqual(mockDelegate.latestCurrentWord, "he")
        
        testObject.addLetterToCurrentWord(letter: "l")
        XCTAssertEqual(mockDelegate.latestCurrentWord, "hel")
        
        testObject.addLetterToCurrentWord(letter: "l")
        XCTAssertEqual(mockDelegate.latestCurrentWord, "hell")
        
        testObject.addLetterToCurrentWord(letter: "o")
        XCTAssertEqual(mockDelegate.latestCurrentWord, "hello")
    }
    
    func test_submitWord_sendsEmptyCurrentWordToDelegate() {
        testObject.addLetterToCurrentWord(letter: "h")
        testObject.addLetterToCurrentWord(letter: "e")
        testObject.addLetterToCurrentWord(letter: "l")
        testObject.addLetterToCurrentWord(letter: "l")
        testObject.addLetterToCurrentWord(letter: "o")
        
        testObject.submitWord()
        
        XCTAssertEqual(mockDelegate.latestCurrentWord, "")
        
    }
    
    func test_submitWord_updatesDelegateWithWordList() {
        testObject.addLetterToCurrentWord(letter: "h")
        testObject.addLetterToCurrentWord(letter: "e")
        testObject.addLetterToCurrentWord(letter: "l")
        testObject.addLetterToCurrentWord(letter: "l")
        testObject.addLetterToCurrentWord(letter: "o")
        
        testObject.submitWord()
        
        XCTAssertEqual(mockDelegate.latestWordList, ["hello"])
        
        testObject.addLetterToCurrentWord(letter: "w")
        testObject.addLetterToCurrentWord(letter: "o")
        testObject.addLetterToCurrentWord(letter: "r")
        testObject.addLetterToCurrentWord(letter: "l")
        testObject.addLetterToCurrentWord(letter: "d")
        
        testObject.submitWord()
        
        XCTAssertEqual(mockDelegate.latestWordList, ["hello", "world"])
        
    }


}
