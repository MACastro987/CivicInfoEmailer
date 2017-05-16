//
//  MainPresenterTest.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/15/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import XCTest
@testable import CivicInfo

class MainPresenterTest: XCTestCase {
        
    func testViewUpdateFromPresenter () {
        //given
        let mockMainView = MockMainView()
        let mockMainPresenter = MainPresenter()
        mockMainPresenter.attachView(view: mockMainView)
        let representativeArray = [Representative]()
        
        //when
        mockMainView.update(representatives: representativeArray)
        
        //assert
        XCTAssertTrue(mockMainView.updateCalled)
    }    
}

//MARK: Test Mocks
extension MainPresenterTest {
    
    class MockMainView: RepresentativeView
    {
        var updateCalled = false
        var reloadCalled = false
        
        func showLoadingIndicator() {
            print("Loading")
        }
        
        func hideLoadingIndicator() {
            print("Loading Indicator Hidden")
        }
        
        func update(representatives: [Representative]) {
            updateCalled = true
        }
        
        func reload() {
            reloadCalled = true
        }
    }
}







