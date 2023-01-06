//
//  WireGuardEndpoint.swift
//  wireguard-tunnel-provider
//
//  Created by VAIF on 1/4/23.
//

import Foundation

struct WireGuardEndpoint {
    
    var ipAddress: String
    var port: Int32?
    var addressType: AddressType
    
    init?(endpointString: String, needsPort: Bool = true) throws {
        var hostString: String
        if needsPort {
            guard let range = endpointString.range(of: ":", options: .backwards, range: nil, locale: nil) else {
                throw EndpointValidationError.noIpAndPort(endpointString)
            }
            
            hostString = String(endpointString[..<range.lowerBound])
            
            let portString = endpointString[range.upperBound...]
            guard let port = Int32(portString), port > 0 else {
                throw EndpointValidationError.invalidPort(String(portString))
            }
            
            self.port = port
        } else {
            hostString = endpointString
        }
        
        hostString = hostString.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
        var addressType = AddressType.validateIpAddress(ipToValidate: hostString)
        let ipString: String
        
        if addressType == .other {
            ipString = WireGuardEndpoint.convertToipAddress(from: hostString)
        } else {
            ipString = hostString
        }
        
        ipAddress = String(ipString)
        addressType = AddressType.validateIpAddress(ipToValidate: ipAddress)
        
        guard addressType == .IPv4 || addressType == .IPv6 else {
            throw EndpointValidationError.invalidIP(ipAddress)
        }
        
        self.addressType = addressType
    }
    
    static func convertToipAddress(from hostname: String) -> String {
        let host = CFHostCreateWithName(nil, hostname as CFString).takeRetainedValue()
        CFHostStartInfoResolution(host, .addresses, nil)
        var success: DarwinBoolean = false
        
        if let addresses = CFHostGetAddressing(host, &success)?.takeUnretainedValue() as NSArray?,
            let theAddress = addresses.firstObject as? NSData {
            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
            
            if getnameinfo(theAddress.bytes.assumingMemoryBound(to: sockaddr.self), socklen_t(theAddress.length), &hostname, socklen_t(hostname.count), nil, 0, NI_NUMERICHOST) == 0 {
                return String(cString: hostname)
            }
        }
        
        return hostname
    }
    
}

extension WireGuardEndpoint {
    
    enum EndpointValidationError: Error {
        
        case noIpAndPort(String)
        case invalidIP(String)
        case invalidPort(String)
        
        var localizedDescription: String {
            switch self {
            case .noIpAndPort:
                return NSLocalizedString("EndpointValidationError.noIpAndPort", comment: "Error message for malformed endpoint.")
            case .invalidIP:
                return NSLocalizedString("EndpointValidationError.invalidIP", comment: "Error message for invalid endpoint ip.")
            case .invalidPort:
                return NSLocalizedString("EndpointValidationError.invalidPort", comment: "Error message invalid endpoint port.")
            }
        }
        
    }
    
}

