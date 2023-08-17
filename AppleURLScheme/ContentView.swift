//
//  ContentView.swift
//  AppleURLScheme
//
//  Created by Mustafa Kılınç on 17.08.2023.
//

import SwiftUI
import MessageUI

struct ContentView: View {
    
    @State var smsMessage = "Merhaba, toplantıya katılacak mısınız?"
    @State var emailMessage = "Merhaba, toplantıya katılacak mısınız?"
    
    private let messageComposeDelegate = MessageComposerDelegate()
    private let mailComposeDelegate = MailComposerDelegate()
    
    var body: some View {
        VStack {
            
            Text("Apple URL Scheme")
                .foregroundColor(Color.blue)
                .contextMenu {
                    
                    Button(action: {
                        self.presentMessageCompose()
                    }) {
                        Text("Mesaj Gönder")
                        Image(systemName: "message")
                    }
                    
                    Button(action: {
                        self.presentMailCompose()
                    }) {
                        Text("E-posta Gönder")
                        Image(systemName: "mail")
                    }
                    
                    Button(action: {
                        startVideoFaceTimeCallAction()
                    }) {
                        Text("Face Time")
                        Image(systemName: "video")
                    }
                    
                    Button(action: {
                        startAudioFaceTimeCallAction()
                    }) {
                        Text("Sesli Face Time")
                        Image(systemName: "phone")
                    }
                    
                }
            
        }
        .padding()
    }
    
    //MARK: Kişi Bilgisi kısmındaki context view görüntülü FaceTime araması yapan method

    private func startVideoFaceTimeCallAction() {
        
        if let facetimeURL : NSURL = NSURL(string: "facetime://+905458422137"){
            let application : UIApplication = UIApplication.shared
            if(application.canOpenURL(facetimeURL as URL)) {
                application.open(facetimeURL as URL)
            }else {
                print("FaceTime is not available")
            }
        }
      
    }
    
    //MARK: Kişi Bilgisi kısmındaki context view sesli FaceTime araması yapan method
    private func startAudioFaceTimeCallAction() {
        if let faceTimeAudioURL : NSURL = NSURL(string: "facetime-audio://+905458422137"){
            let application : UIApplication = UIApplication.shared
            if (application.canOpenURL(faceTimeAudioURL as URL)) {
                application.open(faceTimeAudioURL as URL)
            }else {
                print("FaceTime audio is not available")
            }
        }
        
    }
    
}

//MARK: Kişi Bilgisi kısmındaki context view ile sms göndermek için ContackInfoView'e yazılan extansion

extension ContentView {
    
    private class MessageComposerDelegate : NSObject, MFMessageComposeViewControllerDelegate {
        
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            
            controller.dismiss(animated: true)
            
        }
        
    }
    
    private func presentMessageCompose() {
        guard MFMessageComposeViewController.canSendText() else {
            return
        }
        
        let viewController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        let composeViewController = MFMessageComposeViewController()
        composeViewController.messageComposeDelegate = messageComposeDelegate
        composeViewController.recipients = ["+905458422137"]
        composeViewController.body = smsMessage
        viewController?.present(composeViewController, animated: true)
        
    }
    
}

//MARK: Kişi Bilgisi kısmındaki context view ile e-mail göndermek için ContackInfoView'e yazılan extansion

extension ContentView {
    
    private class MailComposerDelegate: NSObject, MFMailComposeViewControllerDelegate {
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            
            controller.dismiss(animated: true)
        }
    }
    
    private func presentMailCompose() {
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        
        let viewController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        let composeViewController = MFMailComposeViewController()
        composeViewController.setToRecipients(["hamideer36@gmail.com"])
        composeViewController.setMessageBody(smsMessage, isHTML: true)
        composeViewController.mailComposeDelegate = mailComposeDelegate
        
        viewController?.present(composeViewController, animated: true)
    }
}




//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
