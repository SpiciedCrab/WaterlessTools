//
//  PingProvider.swift
//  Waterless
//
//  Created by Harly on 2017/7/16.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit

enum PingResult {
    case pingSuccess(ipAddress : String)
    case pingFailed(errorMessage : String)
}

/// 向外暴露
protocol Pingable : class
{
    /// ping Service
    var pingService : PingProvidable { get set }
    
    
    /// ping一下吧
    ///
    /// - Parameters:
    ///   - host: host地址
    ///   - resultColusre: result
    func startPing(to host : String , wit resultColusre : @escaping (PingResult)->())
}

extension Pingable
{
    func startPing(to host : String , wit resultColusre : @escaping (PingResult)->())
    {
        pingService = PingProvider(hostString: host)
        pingService.pingOnce(result: resultColusre)
    }
}


/// 内部约束
protocol PingProvidable
{
    /// ping一下告诉你ip
    ///
    /// - Parameter result: 结果
    func pingOnce(result : @escaping (PingResult)->())
}

/// 处理ping test
final class PingProvider : NSObject
{
    fileprivate let pingTester : STSimplePing!
    
    fileprivate var pingClosure : ((PingResult)->())? = nil
    
    init(hostString : String)
    {
        pingTester = STSimplePing(hostName: hostString)
        super.init()
        
        pingTester.delegate = self
    }
}

extension PingProvider : STSimplePingDelegate
{
    /// 处理成功
    ///
    /// - Parameters:
    ///   - pinger: pinger
    ///   - address: 啊啊啊
    func st_simplePing(_ pinger: STSimplePing, didStartWithAddress address: Data)
    {
        pingTester.stop()
        
        guard let pingResult = pingClosure  else {

            fatalError("mei closure ni wan ge jb")
        }
        
        if let pingIp = pinger.ipAddress
        {
            pingResult(.pingSuccess(ipAddress: pingIp))
        }
        else
        {
            pingResult(.pingFailed(errorMessage: "ip飞走了"))
        }
        
    }
    
    /// 处理失败
    ///
    /// - Parameters:
    ///   - pinger: pinger
    ///   - address: 啊啊啊
    func st_simplePing(_ pinger: STSimplePing, didFailWithError error: Error)
    {
        pingTester.stop()
        
        guard let pingResult = pingClosure  else {
            
            fatalError("mei closure ni wan ge jb")
        }
        
        pingResult(.pingFailed(errorMessage: "反正就是错了，别玩了～"))
    }
}

extension PingProvider : PingProvidable
{
    func pingOnce(result : @escaping (PingResult)->())
    {
        pingClosure = result
        pingTester.start()
    }
}
