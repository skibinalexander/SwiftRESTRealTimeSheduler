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
    var repeats:    Bool
    
    @objc var completion: (() -> Void)?
    
    init(id: String = "", interval: TimeInterval, repeats: Bool) {
        self.id         = id
        self.interval   = interval
        self.repeats    = repeats
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
    
    public func remove(task: RESTRealTimeShedulerTask) {
        if let index = self.tasks.firstIndex(where: { (find) -> Bool in
            return find.id == task.id
        }) {
            self.timers[index].invalidate()
        }
    }
    
}
