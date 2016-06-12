//
//  QcmWSAdapter.m
//  Qcm
//
//  Created by etudiant on 09/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "QcmWSAdapter.h"
#import "AFNetworking.h"
@implementation QcmWSAdapter

+(NSString*) JSON_ID { return @"id";}
+(NSString*) JSON_LIBELLE { return @"libelle";}
+(NSString*) JSON_DURATION { return @"duration";}
+(NSString*) JSON_NB_POINTS { return @"nbPoints";}
+(NSString*) JSON_CATEGORY{ return @"category";}

-(void) getQcms:(void (^)(NSMutableArray *))callbackQcm :(int)category_id {
    
    // Create session
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    //Create request
    NSString* URL = [NSString stringWithFormat:@"http://192.168.1.39/qcm2/web/app_dev.php/api/lists/%d/qcm",category_id];
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"JSON : %@",responseObject);
        NSMutableArray* qcms = [self extract:responseObject];
        
        // callback(nil);
        callbackQcm(qcms);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error : %@",error);
        callbackQcm(nil);
        
    }];
    
    
}


-(NSMutableArray*) extract:(NSDictionary* )json {
    
     NSMutableArray* qcms = [NSMutableArray new];
    Qcm* qcm = nil;
    
    
    for(NSDictionary*q in json){
        
        qcm = [Qcm new];
        
        NSNumber* id = [q objectForKey:@"id"];
        NSString* libelle = [q objectForKey:@"libelle"];
        NSString* durationString = [q objectForKey:@"duration"];
        NSNumber* points = [q objectForKey:@"nbPoints"];
        NSNumber* category = [q objectForKey:@"category"];
        
        NSDateFormatter* formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss+SSSS"];
        NSDate* duration=[formatter dateFromString:durationString];

        qcm.id_server = [id intValue];
        qcm.libelle = libelle;
        qcm.duration = duration;
        qcm.nbPoints = [points intValue];
        qcm.category_id = [category intValue];
        
        [qcms addObject:qcm];
        
    }
    
    
    return qcms;
}


@end
