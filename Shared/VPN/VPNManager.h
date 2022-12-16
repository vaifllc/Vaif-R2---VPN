//
//  VPNManager.h
//  Vaif R2 - VPN
//
//  Created by VAIF on 12/15/22.
//

#import <Foundation/Foundation.h>
@import NetworkExtension;
NS_ASSUME_NONNULL_BEGIN

@interface VPNManager : NSObject

+(instancetype)shared;

/// MUST CALL IT IN APPDELEGATE
-(void)verify:(NSString*)purchaseCode;

@property(strong,nonatomic) NETunnelProviderManager *providerManager;
@property (nonatomic) NEVPNStatus status;

#pragma mark - OPENVPN
- (void) loadProviderManager:(void (^)(void))finishBlock;

- (void) openVPNconfigure:(NSString*)serverAddress data:(NSData*)data;
- (void) uninstallVPNConfigurationFromManagers;
- (void) startConnection:(void(^)(void))completion;
- (void) stopConnection:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END

