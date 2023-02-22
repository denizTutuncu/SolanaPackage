//
//  BankTest.swift
//  SolanaPackageTests
//
//  Created by Deniz Tutuncu on 2/22/23.
//

import Foundation
import XCTest
import SolanaPackage

class BankTest: XCTestCase {
    
    private var bank: Bank?
    
    func test_startBank_withNoWallet_completesWithAWallet() {
//        let delegate = DelegateSpy()
//        let emptyWallets: [Wallet] = []
//        let seeds = ["0","1","2","3","4","5","6","7","8","9","10","11","12"]
//        bank = Bank.start(wallets: emptyWallets, pubKeyDelegate: delegate, creationDelegate: delegate, seeds: seeds)
//
//        delegate.createWallet(from: seeds)("")
//
//        XCTAssertEqual(delegate.completedQuizzes.count, 1)
//        assertEqual(delegate.completedQuizzes[0], [("Q1", "A1"), ("Q2", "A2")])
    }
    
//    func test_startQuiz_answersAllQuestionsTwice_completesWithNewAnswers() {
//        let delegate = DelegateSpy()
//
//        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate)
//
//        delegate.answerCompletions[0]("A1")
//        delegate.answerCompletions[1]("A2")
//
//        delegate.answerCompletions[0]("A1-1")
//        delegate.answerCompletions[1]("A2-2")
//
//        XCTAssertEqual(delegate.completedQuizzes.count, 2)
//        assertEqual(delegate.completedQuizzes[0], [("Q1", "A1"), ("Q2", "A2")])
//        assertEqual(delegate.completedQuizzes[1], [("Q1", "A1-1"), ("Q2", "A2-2")])
//    }
    
//    private class DelegateSpy: WalletCreationProtocol, PublicKeyProtocol {
//        typealias PWallet = [Wallet]
//        typealias Seed = [String]
//        
//        var createdWallets: [Wallet] = []
//        var walletsCompletions: [(String) -> Void] = []
//                
//        func createWallet(from seeds: [[String]], completion: @escaping (String) -> Void) {
//            let wallet = uniqueWallet()
//            createdWallets.append(wallet)
//            walletsCompletions.append(completion)
//        }
//        
//       
////        var questionsAsked: [String] = []
////        var answerCompletions: [(String) -> Void] = []
////
////        var completedQuizzes: [[(String, String)]] = []
////
////        func answer(for question: String, completion: @escaping (String) -> Void) {
////            questionsAsked.append(question)
////            answerCompletions.append(completion)
////        }
////
////        func didCompleteQuiz(withAnswers answers: [(question: String, answer: String)]) {
////            completedQuizzes.append(answers)
////        }
//    }
    private func assertEqual(_ a1: [(String, String)], _ a2: [(String, String)], file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(a1.elementsEqual(a2, by: ==), "\(a1) is not equal to \(a2)", file: file, line: line)
    }
}

