//
//  QcmWSAdapter.m
//  Qcm
//
//  Created by etudiant on 09/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "QcmWSAdapter.h"
#import "AFNetworking.h"
#import "Question.h"
#import "Proposal.h"
@implementation QcmWSAdapter

+(NSString*) JSON_ID { return @"id";}
+(NSString*) JSON_LIBELLE { return @"libelle";}
+(NSString*) JSON_DURATION { return @"duration";}
+(NSString*) JSON_NB_POINTS { return @"nbPoints";}
+(NSString*) JSON_CATEGORY{ return @"category";}

-(void) getQcms:(void (^)(NSMutableArray *))callbackQcms :(int)category_id {
    
    // Create session
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    //Create request
    NSString* URL = [NSString stringWithFormat:@"http://192.168.1.39/qcm2/web/app_dev.php/api/lists/%d/qcm",category_id];
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"JSON : %@",responseObject);
        NSMutableArray* qcms = [self extract:responseObject];
        
        // callback(nil);
        callbackQcms(qcms);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error : %@",error);
        callbackQcms(nil);
        
    }];
    
    
}

- (void)getQcm:(void (^)(Qcm *))callbackQcm :(int)qcm_id {
    
    // Create session
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    //Create request
    NSString* URL = [NSString stringWithFormat:@"http://192.168.1.39/qcm2/web/app_dev.php/api/qcms/%d",qcm_id];
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"JSON : %@",responseObject);
        Qcm* qcm = [self extractQcm:responseObject];
        
        // callback(nil);
        callbackQcm(qcm);
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

        qcm.id_server = id;
        qcm.libelle = libelle;
        qcm.duration = duration;
        qcm.nbPoints = points;
        qcm.category_id = category;
        
        [qcms addObject:qcm];
        
    }
    
    
    return qcms;
}

-(Qcm*) extractQcm:(NSDictionary* )json {
    Qcm* qcm = [Qcm new];
    for(NSDictionary*q in json){
        NSNumber* id = [json objectForKey:@"id"];
        NSMutableArray* questions = [NSMutableArray new];
        NSDictionary* questionArray = [json objectForKey:@"question_id"];
        
        for(NSDictionary* questionObject in questionArray) {
            
            Question* question = [Question new ];
            
            NSNumber* questionIdServer = [questionObject objectForKey:@"id"];
            NSString* questionLibelle = [questionObject objectForKey:@"libelle"];
            NSNumber* questionPoints = [questionObject objectForKey:@"points"];
            
            NSMutableArray* proposals = [NSMutableArray new];
            
            NSDictionary* proposalArray = [questionObject objectForKey:@"question_prop"];
            
            for(NSDictionary* proposalObject in proposalArray) {
                Proposal* proposal = [Proposal new];
                
                NSNumber* proposalIdServer = [proposalObject objectForKey:@"id"];
                NSString* proposalLibelle = [proposalObject objectForKey:@"libelle"];
                
                proposal.id_server = proposalIdServer;
                proposal.libelle = proposalLibelle;
                
                [proposals addObject:proposal];
            }
            
            question.id_server = questionIdServer;
            question.points = questionPoints;
            question.proposals = proposals;
            question.libelle = questionLibelle;
            
            [questions addObject:question];
            
        }
        
        qcm.id_server = id;
        qcm.questions = questions;
        
    }
    return qcm;
}

@end
