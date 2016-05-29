# AStar
A* search algorithm in Swift

This is a experiment and learn project as much as anything. The basic approach would be for a user to sub-class Node to add the functionality necessary to describe a node in the users real system. One likely element of a subclass would be to override the heuristic, so that it functions as a useful divider. With the default value of 0, this function reverts to being Dijkstra's algorithm. 
