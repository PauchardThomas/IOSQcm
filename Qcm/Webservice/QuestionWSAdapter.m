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

-(void)send:(NSString*)answers{
    // Create session
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];

    
    //Create request
    NSString* URL = @"lien envoi json";
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = serializer;
    
    [manager POST:URL parameters:answers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"Réponses envoyées");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"ERROR : %@ ",error);
    }];
    

}
@end
