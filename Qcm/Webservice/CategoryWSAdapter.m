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

-(void) getCategories:(void(^)(NSMutableArray*))callback{
    
    // Create session
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    //Create request
    NSString* URL = @"http://192.168.1.39/qcm2/web/app_dev.php/api/categories/5";
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"JSON : %@",responseObject);
        NSMutableArray* categories = [self extract:responseObject];
        
       // callback(nil);
        callback(categories);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error : %@",error);
        callback(nil);
        
    }];

    
}

-(NSMutableArray*) extract:(NSDictionary* )json {

    NSMutableArray* categories = [NSMutableArray new];
    EntityCategory* category = nil;
    
    
    for(NSDictionary*cat in json){
        
        category = [EntityCategory new];
        
        NSNumber* myid = [cat objectForKey:@"id"];
        NSString* mylibelle = [cat objectForKey:@"libelle"];
        
        category.id_server = [myid intValue];
        category.libelle = mylibelle;
        
        [categories addObject:category];
        
    }


    return categories;
}

@end
