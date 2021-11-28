//
//  UIImageView.swift
//  FXArticle
//
//  Created by Shashank Mishra on 27/11/21.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension Double {
    func getDateStringFromUTC() -> String {
        var strDate = "undefined"
                
        let unixTime = Double(self/1000)
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
        dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm" //Specify your format that you want
        strDate = dateFormatter.string(from: date)
                
        return strDate
    }
}
