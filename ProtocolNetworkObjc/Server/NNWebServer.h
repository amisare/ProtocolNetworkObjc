//
//  NNWebServer.h
//  ProtocolNetworkObjc
//
//  Created by 顾海军 on 2019/11/10.
//  Copyright © 2019 GuHaiJun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NNWebServer : NSObject

+ (instancetype)shared;
- (void)start;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
