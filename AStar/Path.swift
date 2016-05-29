//
//  Path.swift
//  AStar
//
//  Created by John Ahrens on 5/22/16.
//  Copyright © 2016 John Ahrens. All rights reserved.
//

import Foundation

/**
 * A path exists between two points. Both Nodes are listed here as node1 and node2
 */
class Path
{
    var node1: Node? /// Starting Node for a path
    var node2: Node? /// Ending Node for the path
    var cost: Double /// The cost of traversing from node1 to node2
    
    init()
    {
        node1 = nil
        node2 = nil
        cost = 0.0
    }
    
    init(withNode1 node1:Node, node2:Node, cost:Double)
    {
        self.node1 = node1
        self.node2 = node2
        self.cost = cost
    }
}