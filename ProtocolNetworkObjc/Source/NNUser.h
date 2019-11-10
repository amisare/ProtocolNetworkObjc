//
//  NNUser.h
//  ProtocolNetworkObjc
//
//  Created by GuHaijun on 2019/11/10.
//  Copyright © 2019 GuHaiJun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NNRequest.h"

@interface NNUser : NSObject <NNDecodable>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *message;
- (instancetype)initWithData:(NSData *)data;
@end

