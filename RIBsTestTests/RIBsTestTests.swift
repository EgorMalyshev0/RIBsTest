//
//  RIBsTestTests.swift
//  RIBsTestTests
//
//  Created by Egor Malyshev on 12.08.2022.
//

import XCTest
@testable import RIBsTest

class RIBsTestTests: XCTestCase {

    private var interactor: LoginInteractor!
    private var router: LoginRoutingMock!
    private var listener = LoginListenerMock()
    private var presenter = LoginPresentableMock()
    private var webService = MockWebService()
    
    override func setUp() {
        interactor = LoginInteractor(presenter: presenter, webService: webService)
        router = LoginRoutingMock(interactor: interactor, viewControllable: presenter)
        interactor.listener = listener
        interactor.router = router
        webService.loginHandler = { userName, password, handler in
            if userName == "admin" && password == "admin" {
                handler(.success("admin"))
            } else {
                handler(.failure(LoginError.invalidCredentials))
            }
        }
        super.setUp()
    }
    
    func testDidTapLoginSucceeded() {
        interactor.didTapLogin(username: "admin", password: "admin")
        XCTAssertEqual(presenter.indicatorCallCount, 2)
        XCTAssertEqual(listener.dismissedCallCount, 1)
    }
    
    func testDidTapLoginFailed() {
        interactor.didTapLogin(username: "a", password: "a")
        XCTAssertEqual(presenter.indicatorCallCount, 2)
        XCTAssertEqual(listener.dismissedCallCount, 0)
        XCTAssertEqual(router.showErrorAlertCallCount, 1)
    }
}
