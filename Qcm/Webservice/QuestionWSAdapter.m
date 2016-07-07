//
//  QuestionWSAdapter.m
//  Qcm
//
//  Created by etudiant on 01/07/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "QuestionWSAdapter.h"
#import "AFNetworking.h"
@implementation QuestionWSAdapter

// Send user answers to server
-(void)send:(NSString*)answers{
    
    // Create session
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    //Create request
    NSString* URL = @"http://192.168.100.212/qcm2/web/app_dev.php/api/questions";
    NSDictionary* params = @{@"json": answers};
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = serializer;
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"Réponses envoyées");
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"ERROR : %@ , %@ ",error.localizedDescription,task);
    }];
    

}
@end
