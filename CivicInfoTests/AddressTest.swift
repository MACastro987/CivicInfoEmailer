//
//  AddressTest.swift
//  CivicInfo
//
//  Created by Michael Castro on 5/22/17.
//  Copyright © 2017 Michael Castro. All rights reserved.
//

import XCTest
import CoreLocation
import MapKit
@testable import CivicInfo

class AddressTest: XCTestCase {
    func test_Address_URL_Was_Set() {
        //given
        let mockPlacemark = self.mockPlacemark()
        let mockAddress: Address!
        
        //where
        do {
            mockAddress = try Address(placemark: mockPlacemark)
            
            //assert
            XCTAssertNotNil(mockAddress.url())
        } catch {
            print("mockAddress not set")
        }
    }
}

extension AddressTest {
    func mockPlacemark() -> CLPlacemark {
        return MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 37, longitude: 93))
    }
}
