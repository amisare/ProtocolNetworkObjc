//
//  NNUser.m
//  ProtocolNetworkObjc
//
//  Created by GuHaijun on 2019/11/10.
//  Copyright © 2019 GuHaiJun. All rights reserved.
//

#import "NNUser.h"

@implementation NNUser

- (instancetype)initWithData:(NSData *)data {
    self = [super init];
    if (data != nil) {
        NSDictionary *user = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.name = user[@"name"];
        self.message = user[@"message"];
    }
    return self;
}

@end
