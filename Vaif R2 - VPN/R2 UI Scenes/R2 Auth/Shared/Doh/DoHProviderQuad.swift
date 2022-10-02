//
//  DoHProviderQuad.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/29/22.
//

import Foundation


struct Quad9: DoHProviderInternal {
    
    let networkingEngine: DoHNetworkingEngine

    init(networkingEngine: DoHNetworkingEngine) {
        self.networkingEngine = networkingEngine
    }

    let supported: [Int] = [DNSType.txt.rawValue]

    let url = "https://dns11.quad9.net:5053"

    func query(host: String, sessionId: String?) -> String {
        if let sessionId = sessionId {
            return self.url + "/dns-query?type=TXT&name=" + sessionId + "." + host
        } else {
            return self.url + "/dns-query?type=TXT&name=" + host
        }
    }

    func parse(response: String) -> DNS? {
        return nil
    }

    func parse(data response: Data) -> [DNS]? {
        do {
            guard let dictRes = try JSONSerialization.jsonObject(with: response, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] else {
                // throw error
                return nil
            }

            guard let answers = dictRes["Answer"] as? [[String: Any]] else {
                // throw error
                return nil
            }

            var addrList: [String] = []
            var ttl = -1
            for answer in answers {
                if let type = answer["type"] as? Int, supported.contains(type) {
                    if let addr = answer["data"] as? String {
                        let pureAddr = addr.replacingOccurrences(of: "\"", with: "")
                        addrList.append(pureAddr)
                    }
                    if let timeout = answer["TTL"] as? Int {
                        ttl = timeout
                    }
                }
            }
            if ttl > 0 && addrList.count > 0 {
                var dnsList: [DNS] = []
                for addr in addrList {
                    dnsList.append(DNS(url: addr, ttl: ttl))
                }
                return dnsList
            }
            return nil
        } catch {
            PMLog.debug("parse error: \(error)")
            // throw error
            return nil
        }
    }
}

