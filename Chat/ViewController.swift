//
//  ViewController.swift
//  Chat
//
//  Created by Michael Collard on 4/30/18.
//  Copyright © 2018 Michael Collard. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCBrowserViewControllerDelegate, MCSessionDelegate, UITextFieldDelegate {
    
    @IBOutlet var chatView: UITextView!
    @IBOutlet var messageField: UITextField!
    
    var peerID : MCPeerID!
    var browser : MCBrowserViewController!
    var assistant : MCAdvertiserAssistant!
    var session : MCSession!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.messageField.delegate = self
        
        self.peerID = MCPeerID(displayName: UIDevice.current.name + " Seven")
        self.session = MCSession(peer: self.peerID)
        self.session.delegate = self
        
        // unique service name
        let serviceType = "uacs-chat"
        
        // create a browser view controllaer with a unique service name
        self.browser = MCBrowserViewController(serviceType: serviceType, session: self.session)
        self.browser.delegate = self
        
        // create the assitant for handling peers
        self.assistant = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: nil, session: self.session)
        
        // assistant will start advertising
        self.assistant.start()
    }
    
    func sendChat() {
        
        // convert the string message into Data
        guard let msg = self.messageField.text?.data(using: .utf8) else {
            print("Error: ", #line)
            return
        }

        // send the converted message
        try? self.session.send(msg, toPeers: self.session.connectedPeers, with: .unreliable)

        // update our own chat with the message we just sent
        self.updateChat(name: "Local", text: self.messageField.text!)
        
        // clear out the message field since the message has been sent
        self.messageField.text = ""
    }

    // Allows the user to join the chat
    @IBAction func Join(_ sender: Any) {
        
        self.present(self.browser, animated: true)
    }
    
    // Update the chat view with recent messages
    func updateChat(name: String, text : String) {
        
        // Add the name to the message to the message
        self.chatView.text = self.chatView.text + "\(name): \(text)" + "\n"
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID)  {
        
        // received data put on the main queue
        DispatchQueue.main.async {
            
            // update the chat with the received message
            let msg = String(decoding: data, as: UTF8.self)
            
            self.updateChat(name: peerID.displayName, text: msg as String)
        }

    }
    
    // Make the keyboard disappear once return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.messageField.resignFirstResponder()
        
        self.sendChat()

        // Note: implements default return key behavior
        return true
    }
    
    @IBAction func showBrowser(sender: UIButton) {

    }
    
    // remove the browser view when done
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController)  {
        self.dismiss(animated: true, completion: nil)
    }
    
    // remove the browser view when cancelled
    func browserViewControllerWasCancelled(
        _ browserViewController: MCBrowserViewController)  {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MCSessionDelegate protocol required methods
    
    // Peer starts sending a file to us
    func session(_ session: MCSession,
                 didStartReceivingResourceWithName resourceName: String,
                 fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    
    // File has finished transferring from another peer
    func session(_ session: MCSession,
                 didFinishReceivingResourceWithName resourceName: String,
                 fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
    
    // Peer establishes a stream with us
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    // Connected peer changes state
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
    }
}
