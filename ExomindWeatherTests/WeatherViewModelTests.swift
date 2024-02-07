import XCTest
@testable import ExomindWeather

final class WeatherViewModelTests: XCTestCase {
    func test_GivenDataLoaded_WhenReset_ThenDataIsEmpty() {
        let sut = WeatherViewModel(service: MockWeatherService())
        let fakeCityWeather = CityWeather(city: .paris,
                                          weatherIcon: "",
                                          temperature: 0.0,
                                          humidity: 0)
        // GIVEN
        sut.loadedCities = [fakeCityWeather]
        sut.timerEnabled = false
        
        XCTAssertFalse(sut.loadedCities.isEmpty)
        XCTAssertFalse(sut.timerEnabled)
        
        // WHEN
        sut.reset()
        
        // THEN
        XCTAssertTrue(sut.loadedCities.isEmpty)
        XCTAssertTrue(sut.timerEnabled)
    }

    func test_GivenErrorLoaded_WhenReset_ThenErrorIsNil() {
        let sut = WeatherViewModel(service: MockWeatherService())
        let fakeError = NSError(domain: "FakeError", code: 0)
        // GIVEN
        sut.error = fakeError
        
        XCTAssertNotNil(sut.error)
        
        // WHEN
        sut.reset()
        
        // THEN
        XCTAssertNil(sut.error)
    }
    
    func test_GivenTimerStart_WhenTimerTick_ThenFetchRennesData() async {
        let expectation = expectation(description: "Fetch Rennes Data")
        let mockService = MockWeatherService(getWeatherMock: { city in
            if city == .rennes {
                expectation.fulfill()
                return CityWeatherResponse(name: "Rennes",
                                           weather: [WeatherResponse(icon: "")],
                                           main: MainResponse(temp: 0.0, humidity: 0))
            } else {
                throw NSError(domain: "TestError", code: 0)
            }
        })
        let sut = WeatherViewModel(service: mockService)
        
        // GIVEN
        XCTAssert(sut.loadedCities.isEmpty)
        XCTAssertEqual(sut.loadingProgressValue, 0)
        
        // WHEN
        sut.onTimerTick()
        
        await fulfillment(of: [expectation], timeout: 3)
        
        // THEN
        XCTAssert(!sut.loadedCities.isEmpty)
        XCTAssertEqual(sut.loadingProgressValue, 1)
    }
    
    func test_GivenNoError_WhenApiErrorWhileFetching_ThenErrorIsStored() async {
        let expectation = expectation(description: "Api Error")
        let fakeError = NSError(domain: "FakeError", code: 0)
        let mockService = MockWeatherService(getWeatherMock: { _ in
            expectation.fulfill()
            throw fakeError
        })
        let sut = WeatherViewModel(service: mockService)
        
        // GIVEN
        XCTAssertNil(sut.error)
        
        // WHEN
        sut.onTimerTick()
        
        await fulfillment(of: [expectation], timeout: 3)
        
        // THEN
        XCTAssertNotNil(sut.error)
        XCTAssertEqual(sut.error as? NSError, fakeError)
    }
}
