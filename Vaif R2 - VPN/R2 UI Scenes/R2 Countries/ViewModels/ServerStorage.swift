//
//  ServerStorage.swift
//  VaifR2
//
//  Created by VAIF on 1/7/23.
//

import Foundation

public protocol ServerStorage {
    
    var contentChanged: Notification.Name { get }
    
    func fetch() -> [ServerModel]
    func fetchAge() -> TimeInterval

    func store(_ newServers: [ServerModel])
    func update(continuousServerProperties: ContinuousServerPropertiesDictionary)
}

public protocol ServerStorageFactory {
    func makeServerStorage() -> ServerStorage
}

public class ServerStorageConcrete: ServerStorage {
    
    private let storageVersion = 2
    private let versionKey     = "serverCacheVersion"
    private let storageKey     = "servers"
    private let ageKey         = "age"
    
    private static var servers = [ServerModel]()
    private static var age: TimeInterval?
    
    public var contentChanged = Notification.Name("ServerStorageContentChanged")
    
    public init() {}
    
    public func fetch() -> [ServerModel] {
        // Check if stored servers have been updated since last access,
        // so that widget can stay up to date of app server changes
        let age: TimeInterval = Storage.userDefaults().double(forKey: ageKey)
        
        if ServerStorageConcrete.servers.isEmpty || ServerStorageConcrete.age == nil || age > (ServerStorageConcrete.age! + 1) {
            ServerStorageConcrete.age = age
            
            let version = Storage.userDefaults().integer(forKey: versionKey)
//            if version == storageVersion {
//                if let data = Storage.userDefaults().data(forKey: storageKey),
//                   let servers = try? JSONDecoder().decode([ServerModel].self, from: data) {
//                    ServerStorageConcrete.servers = servers
//                }
//            }
        }
        
        return ServerStorageConcrete.servers
    }
    
    public func fetchAge() -> TimeInterval {
        if let age = ServerStorageConcrete.age {
            return age
        } else {
            let age: TimeInterval = Storage.userDefaults().double(forKey: ageKey)
            ServerStorageConcrete.age = age
            return age
        }
    }
    
    public func store(_ newServers: [ServerModel]) {
        DispatchQueue.global(qos: .default).async { [versionKey, ageKey, storageKey, storageVersion] in
            do {
                let age = Date().timeIntervalSince1970
                //let serversData = try JSONEncoder().encode(newServers.self)
                
                ServerStorageConcrete.age = age
                ServerStorageConcrete.servers = newServers
                
                Storage.userDefaults().set(storageVersion, forKey: versionKey)
                Storage.userDefaults().set(age, forKey: ageKey)
                //Storage.userDefaults().set(serversData, forKey: storageKey)
                Storage.userDefaults().synchronize()
                
                log.debug("Server list saved (count: \(newServers.count))", category: .app)

            } catch {
                log.error("\(error)", category: .app)
            }
            
            DispatchQueue.main.async { NotificationCenter.default.post(name: self.contentChanged, object: newServers) }
        }
    }
    
    public func update(continuousServerProperties: ContinuousServerPropertiesDictionary) {
        let servers = fetch()
//        servers.forEach { (server) in
//            if let properties = continuousServerProperties[server.ovpnName] {
//                server.update(continousProperties: properties)
//            }
//        }
        
        store(servers)
    }
}

