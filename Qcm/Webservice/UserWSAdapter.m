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

-(User* ) loginuser:(void(^)(User*)) callbackUser:username:password{
    
    // Create session
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    NSLog(@"%@",username);
    NSLog(@"%@",password);
    
    //Create request
    NSString* URL = @"http://192.168.1.39/qcm2/web/app_dev.php/api/users";
    NSDictionary* params = @{@"username": @"admin",
                             @"password": @"admin"};
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = serializer;
    
    __block User* user;
    
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"JSON : %@",responseObject);
        
        user = [self extract:responseObject];
        NSLog(@"test1");
        callbackUser(user);
        
        UserSqLiteAdapter* userSqlAdapter = [UserSqLiteAdapter new ];
        NSManagedObject* userMO =[userSqlAdapter getBy:user.username :user.password];
        NSLog(@"test2");
        user = (User*) userMO;

        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"ERROR : %@ ",error);
        
        
    }];
    [manager.operationQueue waitUntilAllOperationsAreFinished];
    
    NSLog(@"Username : %@ , Password : %@ , id : %@",user.username,user.password,user.id);
    return user;
    
    
}

-(User*) extract:(NSDictionary* )json {
    

    User* user = nil;
    user = [User new];
    for(NSDictionary* u in json) {
    NSNumber* myid = [u objectForKey:@"id"];
    NSString* myusername = [u objectForKey:@"username"];
    NSString* mypassword = [u objectForKey:@"password"];
    
    user.id_server = [myid intValue];
    user.username = myusername;
    user.password = mypassword;
    }
    return user;
    
}


@end
