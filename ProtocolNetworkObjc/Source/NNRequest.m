//
//  NNRequest.m
//  ProtocolNetworkObjc
//
//  Created by GuHaijun on 2019/11/10.
//  Copyright © 2019 GuHaiJun. All rights reserved.
//

#import "NNRequest.h"
#import "NNUser.h"


@nn_extension(NNDecodable, @nn_where(NNUser, self == [NNUser class]))

+ (id<NNDecodable>)parse:(NSData *)data {
    return [[NNUser alloc] initWithData:data];
}

@end

@nn_extension(NNRequest)

- (NSString *)methodName {
    NSString *name = @"";
    switch (self.method) {
        case NNHTTPMethodGET: {
            name = @"GET";
            break;
        }
        case NNHTTPMethodPOST: {
            name = @"POST";
            break;
        }
        default:
            name = @"GET";
            break;
    }
    return name;
}

@end

@nn_extension(NNRequestSender)

- (NSString *)host {
    return @"http://localhost:8080";
}

@end


@implementation URLSessionRequestSender

- (void)send:(id<NNRequest>)r handler:(void (^)(id<NNDecodable>))handler {
    
    NSURL *url = [[NSURL alloc] initWithString:[self.host stringByAppendingString:r.path]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = r.methodName;
    
    NSURLSessionTask *task = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        id<NNDecodable> obj = [r.Response parse:data];
        if (handler) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(obj);
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(nil);
            });
        }
    }];
    [task resume];
}

@end


@implementation NNUserRequest

- (NSString *)path {
    return [NSString stringWithFormat:@"/users/%@", self.name];
}

- (NNHTTPMethod)method {
    return NNHTTPMethodGET;
}

- (Class<NNDecodable>)Response {
    return [NNUser class];
}

@end
