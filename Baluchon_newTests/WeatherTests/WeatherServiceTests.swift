//
//  WeatherServiceTests.swift
//  Baluchon_newTests
//
//  Created by Mélanie Obringer on 01/10/2019.
//  Copyright © 2019 Mélanie Obringer. All rights reserved.
//

import XCTest
@testable import Baluchon_new

class WeatherServiceTests: XCTestCase {

    // test if callback returns an error
    func testTranslateShouldPostFailedCallbackIfError() {
        let weather = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weather.getWeather(from: "Strasbourg") { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // test if callback doesn't return data
    func testTranslateShouldPostFailedCallbackIfNoData() {
        let weather = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weather.getWeather(from: "Strasbourg") { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // test if callback returns an incorrect response
    func testTranslateShouldPostFailedCallbackIncorrectResponse() {
        let weather = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weather.getWeather(from: "Strasbourg") { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // test if callback returns incorrect data
    func testTranslateShouldPostFailedCallbackIncorrectData() {
        let weather = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weather.getWeather(from: "Strasbourg") { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // test if callback returns success with no error and correct data
    func testTranslateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let weather = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weather.getWeather(from: "Strasbourg") { result in
                guard case .success (let weather) = result else {
                    XCTFail("Test request method with an error failed.")
                    return
                }
            
            let fakeWeatherWind: Float = 3.1
            let fakeWeatherTemp: Float = 17.3
            let fakeWeather: String = "Rain"

            
            XCTAssertEqual(fakeWeatherWind, weather.wind.speed)
            XCTAssertEqual(fakeWeatherTemp, weather.main.temp)
            XCTAssertEqual(fakeWeather, weather.weather[0].main)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
