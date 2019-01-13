//
//  ViewController.swift
//  Speech Recognition
//
//  Created by Prabhapaar Singh Batra on 2019-01-13.
//  Copyright © 2019 Prabhapaar Singh Batra. All rights reserved.
//

import UIKit
import Speech
import AudioToolbox
import AVFoundation

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}

class ViewController: UIViewController, SFSpeechRecognizerDelegate {

    
    @IBOutlet weak var detectedTextLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var triggerWord: UILabel!
    @IBOutlet weak var endButton: UIButton!
    
    let audioEngine = AVAudioEngine()
    let audioEngine1 = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let speechRecognizer1: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    let request1 = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var recognitionTask1: SFSpeechRecognitionTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recordAndRecognizeSpeechDefault()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func startButtonTapped(_ sender: UIButton) {
        self.recordAndRecognizeSpeech()
    }

    @IBAction func endButtonTapped(_ sender: UIButton) {
    }
    
    func recordAndRecognizeSpeechDefault() {
        guard let node: AVAudioInputNode = audioEngine.inputNode else { return }
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in self.request.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print(error)
        }
        guard let myRecognizer = SFSpeechRecognizer() else {
            // A recognizer is not supported for current locale
            return
        }
        if !myRecognizer.isAvailable {
            // A recognizer is not available right now
            return
        }
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
                let bestString = result.bestTranscription.formattedString
                
                var lastString: String = ""
                for segment in result.bestTranscription.segments {
                    let indexTo = bestString.index(bestString.startIndex, offsetBy: segment.substringRange.location)
                    lastString = bestString.substring(from: indexTo)
                    if self.checkForTriggerWord(resultString: lastString) {
                        self.recordAndRecognizeSpeech()
                    }
                }
                
            } else if let error = error {
                print(error)
            }
        })
    }
    
    
    func recordAndRecognizeSpeech() {
        guard let node1: AVAudioInputNode = audioEngine1.inputNode else { return }
         let recordingFormat1 = node1.outputFormat(forBus: 0)
        node1.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat1) { buffer, _ in self.request1.append(buffer)
        }
        audioEngine1.prepare()
        do {
            try audioEngine1.start()
        } catch {
            return print(error)
        }
        guard let myRecognizer1 = SFSpeechRecognizer() else {
            // A recognizer is not supported for current locale
            return
        }
        if !myRecognizer1.isAvailable {
            // A recognizer is not available right now
            return
        }
        recognitionTask1 = speechRecognizer1?.recognitionTask(with: request1, resultHandler: { result1, error1 in
            if let result1 = result1 {
                let bestString1 = result1.bestTranscription.formattedString
                self.detectedTextLabel.text = bestString1
                
             // var lastString: String = ""
              //  for segment in result.bestTranscription.segments {
             //       let indexTo = bestString.index(bestString.startIndex, offsetBy: segment.substringRange.location)
            //        lastString = bestString.substring(from: indexTo)
            //   }
                
            } else if let error1 = error1 {
                print(error1)
            }
        })
    }
    
    
    func checkForTriggerWord(resultString: String) ->Bool {
        switch resultString {
        case "Hello":
            return true
        case "Hey":
            return true
        case "hey":
            return true
        case "rain":
            return true
        case "cat":
            return true
        case "dog":
            return true
        default: return false
        }
        
    }
   
}

