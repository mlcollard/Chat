//
//  ViewController.swift
//  Chat
//
//  Created by Michael Collard on 4/30/18.
//  Copyright © 2018 Michael Collard. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCBrowserViewControllerDelegate,
MCSessionDelegate, UITextFieldDelegate {
    
    @IBOutlet var chatView: UITextView!
    @IBOutlet var messageField: UITextField!
    
    var peerID : MCPeerID!
    var browser : MCBrowserViewController!
    var assistant : MCAdvertiserAssistant!
    var session : MCSession!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.messageField.delegate = self
    }

    func sendChat() {

    }

    // Allows the user to join the chat
    @IBAction func Join(_ sender: Any) {

    }
    
    // Update the chat view with recent messages
    func updateChat(name: String, text : String) {
        
        // Add the name to the message to the message
        self.chatView.text = self.chatView.text + "\(name): \(text)" + "\n"
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID)  {

    }
    
    // Make the keyboard disappear once return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.messageField.resignFirstResponder()

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
