//
//  UserWSAdapter.m
//  Qcm
//
//  Created by etudiant on 29/05/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "UserWSAdapter.h"
#import "AFNetworking.h"
#import "User.h"
#import "UserSqLiteAdapter.h"
@implementation UserWSAdapter

+(NSString*) JSON_USERNAME{ return @"username";}
+(NSString*) JSON_PASSWORD {return @"password";}
+(NSString*) JSON_ID_SERVER {return @"id_server";}
+(NSString*) BASE_URL {return @"http://192.168.100.212/qcm2/web/app_dev.php/api/users";}
-(User* ) loginuser:(void(^)(User*)) callbackUser:username:password{
    
    // Create session
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    NSLog(@"%@",username);
    NSLog(@"%@",password);
    
    //Create request
    NSString* URL = UserWSAdapter.BASE_URL;
    NSDictionary* params = @{@"username": username,
                             @"password": password};
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = serializer;
    
    __block User* user;
    
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        // Extract response to user

        user = [self extract:responseObject];

        callbackUser(user);
        
        UserSqLiteAdapter* userSqlAdapter = [UserSqLiteAdapter new ];
        NSManagedObject* userMO =[userSqlAdapter getBy:user.username :user.password];

        user = (User*) userMO;

        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"ERROR : %@ ",error);
    }];
    
    [manager.operationQueue waitUntilAllOperationsAreFinished];
    
    return user;
    
    
}

-(User*) extract:(NSDictionary* )json {
    

    User* user = nil;
    user = [User new];
    for(NSDictionary* u in json) {
    NSNumber* myid = [u objectForKey:@"id"];
    NSString* myusername = [u objectForKey:UserWSAdapter.JSON_USERNAME];
    NSString* mypassword = [u objectForKey:UserWSAdapter.JSON_PASSWORD];
    
    user.id_server = myid;
    user.username = myusername;
    user.password = mypassword;
    }
    return user;
    
}


@end
