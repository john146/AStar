//
//  Node.swift
//  AStar
//
//  Created by John Ahrens on 5/22/16.
//  Copyright © 2016 John Ahrens. All rights reserved.
//

import Foundation

/**
 * Node represents a point on a path. It is an end point that has one or more paths connected to it. Start and End are 
 * nodes, as are any points that you may pass through in between.
 *
 * In a real application, this class will need to be sub-classed to provide the means of handling application unique 
 * features of the Node. One such feature is the means of calculating the heuristic cost to get to the end point.
 */
class Node
{
    var paths:Array<Path>? /// Paths define the connections between two nodes
    var cameFrom: Node? /// The last Node accessed before arriving at this Node.
    var gScore: Double /// The distance from start to this Node
    var fScore: Double /// The distance from start to end, passing through this node
    var heuristic: Double /// This value defaults to 0, but should be overridden by a child class to do something interesting
    
    init()
    {
        self.paths = Array<Path>()
        self.cameFrom = nil
        self.gScore = DBL_MAX
        self.fScore = DBL_MAX
        self.heuristic = 0.0
    }
    
    init(withPaths paths:Array<Path>)
    {
        self.paths = paths
        self.cameFrom = nil
        self.gScore = DBL_MAX
        self.fScore = DBL_MAX
        self.heuristic = 0.0
    }
}