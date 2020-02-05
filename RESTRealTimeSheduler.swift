//
//  RESTRealTimeSheduler.swift
//  Vezu
//
//  Created by Ольга on 13/05/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

class RESTRealTimeShedulerTask {
    // MARK: - Properties
    var id:         String
    var interval:   TimeInterval
    var count:      Int?
    var repeats:    Bool
    
    @objc var completion: (() -> Void)?
    
    init(id: String, interval: TimeInterval, count: Int? = nil, repeats: Bool, completion: (() -> Void)? = nil) {
        self.id         = id
        self.interval   = interval
        self.count      = count
        self.repeats    = repeats
        self.completion = completion
    }
    
    @objc func invoke() {
        self.completion?()
    }

}

class RESTRealTimeShedulerManager {
    // MARK: - Static
    static let shared: RESTRealTimeShedulerManager = RESTRealTimeShedulerManager()
    
    // MARK: - Private Properties
    private var timers: [Timer]
    private var tasks:  [RESTRealTimeShedulerTask]
    
    // MARK: - Public Properties
    public var taskIds: [String] {
        return tasks.map({ $0.id })
    }
    
    // MARK: - Lifecycle
    init() {
        self.timers = []
        self.tasks  = []
    }
    
    // MARK: - Public Implementation
    public func add(task: RESTRealTimeShedulerTask) {
        let timer = Timer.scheduledTimer(timeInterval: task.interval,
                                         target: task,
                                         selector: #selector(RESTRealTimeShedulerTask.invoke),
                                         userInfo: nil,
                                         repeats: task.repeats)
        self.timers.append(timer)
        self.tasks.append(task)
    }
    
    public func remove(task id: String) {
        if let index = self.tasks.firstIndex(where: { $0.id == id }) {
            self.timers[index].invalidate()
            self.timers.remove(at: index)
            self.tasks.remove(at: index)
        }
    }
    
}
