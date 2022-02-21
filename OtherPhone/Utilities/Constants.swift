//
//  Constants.swift
//  OtherPhone
//
//  Created by Zulqarnain on 20/02/2022.
//

import Foundation

import UIKit

class Constants: NSObject {

    static let appdel = UIApplication.shared.delegate as! AppDelegate
    
    struct NETSERVICE {
        static let type = "_servicetype._tcp."
        static let name = "Tic-Tac-Toe"
        static let domain = "local."
        static let host_port: UInt16 = 8080
        static let joinSoc = "Join_soc"
        static let hostSoc = "Host_soc"
        static let acceptedMsg = "Accepted"
        static let socketConnected = "SOCKET CONNECTION TESTED"
    }
}
