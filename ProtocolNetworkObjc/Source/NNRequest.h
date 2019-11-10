//
//  NNRequest.h
//  ProtocolNetworkObjc
//
//  Created by GuHaijun on 2019/11/10.
//  Copyright © 2019 GuHaiJun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NNHTTPMethod) {
    NNHTTPMethodGET,
    NNHTTPMethodPOST,
};


@protocol NNDecodable <NSObject>
@optional
+ (id<NNDecodable>)parse:(NSData*)data;
@end


@protocol NNRequest <NSObject>
@optional
@property (nonatomic, strong) NSString *path;
@property (nonatomic, assign) NNHTTPMethod method;
@property (nonatomic, strong) NSString *methodName;
@property (nonatomic, strong) NSString *parameter;
@property (nonatomic, strong) Class<NNDecodable> Response;
@end


@protocol NNRequestSender <NSObject>
@optional
@property (nonatomic, strong) NSString *host;
- (void)send:(id<NNRequest>)r handler:(void (^)(id<NNDecodable> response))handler;
@end


@interface NNUserRequest : NSObject <NNRequest>
@property (nonatomic, strong) NSString *name;
@end


@interface URLSessionRequestSender : NSObject <NNRequestSender>

@end


