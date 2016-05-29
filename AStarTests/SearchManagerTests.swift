//
//  SearchManagerTests.swift
//  AStar
//
//  Created by John Ahrens on 5/22/16.
//  Copyright © 2016 John Ahrens. All rights reserved.
//

import XCTest

class SearchManagerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
}
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    /**
     * Tests the case where the map looks like start---end. Single path, no intermediate nodes.
     */
    func testSinglePathNoIntermediateNodes() {
        let start = Node()
        let end = Node()
        let startPath = Path(withNode1: start, node2: end, cost: 1)
        start.paths?.append(startPath)
        let endPath = Path(withNode1: end, node2: start, cost: 1)
        end.paths?.append(endPath)
        let searchManager = SearchManager(withStart: start, end: end)
        
        XCTAssert(searchManager.findPath())
        let totalPath = searchManager.recreatePath(end)
        
        XCTAssertEqual(2, totalPath.count)
        XCTAssertTrue(totalPath[0] === start)
        XCTAssertTrue(totalPath[1] === end)
    }

    /**
     * Tests the case where there is a node between the start and end nodes, but there is still only one possible path.
     */
    func testSinglePathOneIntermediateNode() {
        let start = Node()
        start.gScore = 0.0
        let end = Node()
        let nodeA = Node()
        let startPath = Path(withNode1: start, node2: nodeA, cost: 1.0)
        let pathAStart = Path(withNode1: nodeA, node2: start, cost: 1.0)
        let pathAEnd = Path(withNode1: nodeA, node2: end, cost: 1.5)
        let endPath = Path(withNode1: end, node2: nodeA, cost: 1.5)
        start.paths?.append(startPath)
        nodeA.paths?.append(pathAStart)
        nodeA.paths?.append(pathAEnd)
        end.paths?.append(endPath)
        let searchManager = SearchManager(withStart: start, end: end)
        
        XCTAssertTrue(searchManager.findPath())
        let totalPath = searchManager.recreatePath(end)
        
        XCTAssertEqual(3, totalPath.count)
        XCTAssertTrue(totalPath[0] === start)
        XCTAssertTrue(totalPath[1] === nodeA)
        XCTAssertTrue(totalPath[2] === end)
    }
    
    /**
     * Tests the case with two possible paths. The shortest first leg leads to the shortest path.
     */
    func testTwoPathsTwoIntermediateNodesShortestFirstLegShortestPath() {
        let start = Node()
        start.gScore = 0.0
        let end = Node()
        let nodeA = Node()
        let nodeB = Node()
        let startPathA = Path(withNode1: start, node2: nodeA, cost: 1.0)
        start.paths?.append(startPathA)
        let pathAStart = Path(withNode1: nodeA, node2: start, cost: 1.0)
        nodeA.paths?.append(pathAStart)
        let startPathB = Path(withNode1: start, node2: nodeB, cost: 1.5)
        start.paths?.append(startPathB)
        let pathBStart = Path(withNode1: nodeB, node2: start, cost: 1.5)
        nodeB.paths?.append(pathBStart)
        let pathAEnd = Path(withNode1: nodeA, node2: end, cost: 1.5)
        nodeA.paths?.append(pathAEnd)
        let endPathA = Path(withNode1: end, node2: nodeA, cost: 1.5)
        end.paths?.append(endPathA)
        let pathBEnd = Path(withNode1: nodeB, node2: end, cost: 1.5)
        nodeB.paths?.append(pathBEnd)
        let endPathB = Path(withNode1: end, node2: nodeB, cost: 1.5)
        end.paths?.append(endPathB)
        let searchManager = SearchManager(withStart: start, end: end)
        
        XCTAssertTrue(searchManager.findPath())
        let totalPath: Array<Node> = searchManager.recreatePath(end)
        
        XCTAssertEqual(3, totalPath.count)
        XCTAssertTrue(totalPath[0] === start)
        XCTAssertTrue(totalPath[1] === nodeA)
        XCTAssertTrue(totalPath[2] === end)
    }
    
    /**
     * Tests the condition where there is no route from start to finish
     */
    func testNoPathToEnd() {
        let start = Node()
        start.gScore = 0.0
        let end = Node()
        let nodeA = Node()
        let startNodeA = Path(withNode1: start, node2: nodeA, cost: 5.0)
        start.paths?.append(startNodeA)
        let nodeAStart = Path(withNode1: nodeA, node2: start, cost: 5.0)
        nodeA.paths?.append(nodeAStart)
        let nodeB = Node()
        let nodeANodeB = Path(withNode1: nodeA, node2: nodeB, cost: 3.5)
        nodeA.paths?.append(nodeANodeB)
        let nodeBNodeA = Path(withNode1: nodeB, node2: nodeA, cost: 3.5)
        nodeB.paths?.append(nodeBNodeA)
        let nodeBStart = Path(withNode1: nodeB, node2: start, cost: 6.2)
        nodeB.paths?.append(nodeBStart)
        let startNodeB = Path(withNode1: start, node2: nodeB, cost: 6.2)
        start.paths?.append(startNodeB)
        let searchManager = SearchManager(withStart: start, end: end)
        
        XCTAssertFalse(searchManager.findPath())
    }
}
