//
//  XCTest.swift
//  FXArticleTests
//
//  Created by Shashank Mishra on 28/11/21.
//

import XCTest

extension XCTestCase {

    func loadStub(name: String, extension: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)
        return try! Data(contentsOf: url!)
    }

}
