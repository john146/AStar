//
//  SearchManager.swift
//  AStar
//
//  Created by John Ahrens on 5/22/16.
//  Copyright © 2016 John Ahrens. All rights reserved.
//

import Foundation

/**
 * SearchManager is a controller object in the Model/View/Controller sense of things. It does the work of finding the 
 * path to the end point.
 */
class SearchManager
{
    var closedSet: Array<Node> /// Set of nodes already evaluated
    var openSet: Array<Node> /// Set of nodes still to be evaluated. Initially only the starting point
    var start: Node
    var end: Node
    
    init(withStart start: Node, end: Node)
    {
        closedSet = Array<Node>()
        openSet = Array<Node>(arrayLiteral: start)
        self.start = start
        self.end = end
    }
    
    func findPath() -> Bool
    {
        var current = Node()
        start.fScore = start.heuristic
        while (0 < openSet.count)
        {
            current = openSet.popLast()!
            if current === end
            {
                return true
            }
            
            closedSet.append(current)
            for path in current.paths!
            {
                let nextNode = path.node2
                if closedSet.contains({$0 === nextNode})
                {
                    // This node has already been evaluated.
                    continue
                }
                
                let cost = current.gScore + path.cost
                if !openSet.contains({$0 === nextNode})
                {
                    openSet.append(nextNode!)
                }
                else if cost >= nextNode!.gScore
                {
                    continue
                }
                
                nextNode!.cameFrom = current
                nextNode!.gScore = current.gScore + path.cost
                nextNode!.fScore = (nextNode?.gScore)! + (nextNode?.heuristic)!
                openSet.sortInPlace {
                    $0.fScore > $1.fScore
                }
            }
        }
        
        return false
    }
    
    func recreatePath(fromNode: Node) -> Array<Node>
    {
        var pathToEnd: Array<Node> = []
        if fromNode !== start
        {
            pathToEnd = recreatePath(fromNode.cameFrom!)
        }
        
        pathToEnd.append(fromNode)
        return pathToEnd
    }
}