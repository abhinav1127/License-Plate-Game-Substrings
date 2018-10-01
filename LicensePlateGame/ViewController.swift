//
//  ViewController.swift
//  LicensePlateGame
//
//  Created by Abhinav Tirath on 4/18/18.
//  Copyright © 2018 Abhinav Tirath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var allPossibleWords: [String] = []
    var words: [String] = []
    @IBOutlet var wordsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBOutlet var subsequenceField: UITextField!
    @IBAction func submitButton(_ sender: Any) {
        
        words.removeAll()
        
        if let subsequence = subsequenceField.text, subsequence != "" {
            for word in allPossibleWords {
                if (isSubsequence(sequence: subsequence, word: word, m: subsequence.count, n: word.count)) {
                    words.append(word)
                }
            }
        } else {
            print("empty field")
        }
        
        self.wordsTable.reloadData()
    }
    
    // Returns true if str1[] is a subsequence of str2[]
    // m is length of sequence and n is length of word
    func isSubsequence(sequence: String, word: String, m: Int, n: Int) -> Bool {
        //base cases
        if (m == 0) {
            return true
        }
        if (n == 0) {
            return false
        }
        
        let index1 = sequence.index(sequence.startIndex, offsetBy: m - 1)
        let index2 = word.index(word.startIndex, offsetBy: n - 1)
        
        if (word[index2] == sequence[index1]) {
            return isSubsequence(sequence: sequence, word: word, m: m - 1, n: n - 1)
        } else {
            return isSubsequence(sequence: sequence, word: word, m: m, n: n - 1)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let wordsFilePath1 = Bundle.main.path(forResource: "words", ofType: "txt") {
            do {
                let wordsString = try String(contentsOfFile: wordsFilePath1)
                
                let wordLines = wordsString.components(separatedBy: .newlines)
                
                allPossibleWords = wordLines
                
            } catch { // contentsOfFile throws an error
                print("Error: \(error)")
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = words[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("accessed")
        print(words[indexPath.row])
//        if UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: words[indexPath.row]) {
        print("in")
        let ref: UIReferenceLibraryViewController = UIReferenceLibraryViewController(term: words[indexPath.row])
        self.present(ref, animated: true, completion: nil)
        //}
    }
    
}

