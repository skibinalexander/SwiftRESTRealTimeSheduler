//
//  RESTRealTimeSheduler.swift
//  Vezu
//
//  Created by Ольга on 13/05/2019.
//  Copyright © 2019 VezuAppDevTeam. All rights reserved.
//

import Foundation

class RESTRealTimeShedulerTask {
    
    //  MARK: Properties
    
    var id:         String
    var interval:   TimeInterval
    var repeats:    Bool
    
    @objc var completion:   (()->Void)?
    
    init(id: String) {
        self.id = id
        self.interval = 0.5
        self.repeats = true
    }

}

class RESTRealTimeShedulerManager {
    
    static let shared: RESTRealTimeShedulerManager = RESTRealTimeShedulerManager()
    
    private var timers: [Timer]
    private var tasks:  [RESTRealTimeShedulerTask]
    
    init() {
        self.timers = []
        self.tasks  = []
    }
    
    public func add(task: RESTRealTimeShedulerTask) {
        let timer = Timer.scheduledTimer(timeInterval: task.interval,
                                         target: task,
                                         selector: #selector(getter: RESTRealTimeShedulerTask.completion),
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
