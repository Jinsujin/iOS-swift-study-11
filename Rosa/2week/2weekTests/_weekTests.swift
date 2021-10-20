//
//  _weekTests.swift
//  2weekTests
//
//  Created by jsj on 2021/09/12.
//

import XCTest
@testable import _week

/**
테스트 실행: command + U
 
 setUp () :
 초기화 코드. 테스트 메서드가 실행되기 전 모든 상태를 reset 해준다.

 tearDown()
해체코드. 테스트 메서드의 동작이 끝나면 모든 상태를 cleanup 시켜준다
 
 */

class _weekTests: XCTestCase {
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_viewModel() {
        let vm = MovieViewModel()
        XCTAssertEqual(vm.updateMovieTitles(titles: ["1", "2"]), "00")
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
