//
//  Queue.swift
//  Peggle
//
//  Created by proglab on 14/2/24.
//

import Foundation

/// Simple generic queue struct that uses 2 stacks representation
/// Includes:
/// - enqueue
/// - dequeue
/// - clear
/// - count
/// - toString
/// - isEmpty
struct Queue<T> {
    private var inbox: [T] = []
    private var outbox: [T] = []
    var count: Int { inbox.count + outbox.count }
    var toString: String { "\(outbox.reversed() + inbox)" }

    mutating func enqueue(_ item: T) {
        inbox.append(item)
    }

    mutating func dequeue() -> T? {
        if outbox.isEmpty {
            if inbox.isEmpty {
                return nil // Queue is empty
            }
            // Transfer elements from inbox to outbox to reverse the order
            while let item = inbox.popLast() {
                outbox.append(item)
            }
        }
        // Pop from outbox
        return outbox.popLast()
    }

    mutating func clear() {
        inbox.removeAll()
        outbox.removeAll()
    }

    // Check if the queue is empty
    func isEmpty() -> Bool {
        return inbox.isEmpty && outbox.isEmpty
    }
}
