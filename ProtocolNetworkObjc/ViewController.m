//
//  ViewController.m
//  ProtocolNetworkObjc
//
//  Created by GuHaijun on 2019/11/10.
//  Copyright © 2019 GuHaiJun. All rights reserved.
//

#import "ViewController.h"
#import "NNWebServer.h"
#import "NNUser.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NNWebServer shared] start];
    
    NNUserRequest *request = [NNUserRequest new];
    request.name = @"popobjc";
    [[URLSessionRequestSender new] send:request handler:^(id<NNDecodable> response) {
        NNUser *user = (NNUser *)response;
        self.nameLabel.text = user.name;
        self.messageLabel.text = user.message;
    }];
}

@end
