//
//  CategoryWSAdapter.m
//  Qcm
//
//  Created by etudiant on 08/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "CategoryWSAdapter.h"
#import "AFNetworking.h"
@implementation CategoryWSAdapter

+(NSString*) JSON_LIBELLE{ return @"libelle";}
+(NSString*) JSON_ID_SERVER {return @"id";}
+(NSString*) BASE_URL{return @"http://192.168.100.212/qcm2/web/app_dev.php/api/categories";}

// Get categories
// Parameter : int user_id
-(void) getCategories:(void(^)(NSMutableArray*))callback:(int)user_id{
    
    // Create session
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    //Create request
    NSString* URL = [NSString stringWithFormat:@"%@/%d",CategoryWSAdapter.BASE_URL,user_id];
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // Extract reponse to categories
        NSMutableArray* categories = [self extract:responseObject];

        callback(categories);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error : %@",error);
        callback(nil);
        
    }];

    
}

// Extract categories from server response
-(NSMutableArray*) extract:(NSDictionary* )json {

    NSMutableArray* categories = [NSMutableArray new];
    EntityCategory* category = nil;
    
    
    for(NSDictionary*cat in json){
        
        category = [EntityCategory new];
        
        NSNumber* myid = [cat objectForKey:CategoryWSAdapter.JSON_ID_SERVER];
        NSString* mylibelle = [cat objectForKey:CategoryWSAdapter.JSON_LIBELLE];
        
        category.id_server = myid;
        category.libelle = mylibelle;
        
        [categories addObject:category];
        
    }


    return categories;
}

@end
