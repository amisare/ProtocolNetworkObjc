//
//  NNWebServer.m
//  ProtocolNetworkObjc
//
//  Created by 顾海军 on 2019/11/10.
//  Copyright © 2019 GuHaiJun. All rights reserved.
//

#import "NNWebServer.h"

@interface NNWebServer() <GCDWebServerDelegate>

@property (nonatomic, strong) GCDWebServer *server;

@end

@implementation NNWebServer

static NNWebServer* _instance = nil;

+ (instancetype)shared {

    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[NNWebServer alloc] init];
            [_instance buildServer];
        });
    }
    return _instance;
}

- (void)start {
    NSMutableDictionary* options = [NSMutableDictionary dictionary];
    [options setObject:@8080 forKey:GCDWebServerOption_Port];
    [options setObject:@(true) forKey:GCDWebServerOption_BindToLocalhost];
    [self.server startWithOptions:options error:nil];
}

- (void)stop {
    [self.server stop];
}

- (GCDWebServer *)server {
    if (!_server) {
        _server = [[GCDWebServer alloc] init];
        _server.delegate = self;
    }
    return _server;
}

- (void)buildServer {
    
    [self.server addHandlerForMethod:@"GET"
                                path:@"/users/popobjc"
                        requestClass:[GCDWebServerRequest class]
                   asyncProcessBlock:^(GCDWebServerRequest* request, GCDWebServerCompletionBlock completionBlock) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSDictionary *resp = @{
                @"name" : @"popobjc",
                @"message" : @"hello pop objc!",
            };
            NSData *respData = [NSJSONSerialization dataWithJSONObject:resp options:0 error:nil];
            GCDWebServerDataResponse* response = [GCDWebServerDataResponse
                                                  responseWithData:respData
                                                  contentType:@"text/plain"];
            completionBlock(response);
        });
    }];
}

@end
