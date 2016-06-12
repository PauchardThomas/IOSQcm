//
//  QcmWSAdapter.h
//  Qcm
//
//  Created by etudiant on 09/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Qcm.h"
@interface QcmWSAdapter : NSObject

-(void) getQcms:(void(^)(NSMutableArray*))callbackQcm:(int)category_id;
-(NSMutableArray*) extract:(NSDictionary* )json;
+(NSString*) JSON_ID;
+(NSString*) JSON_LIBELLE;
+(NSString*) JSON_DURATION;
+(NSString*) JSON_NB_POINTS;
+(NSString*) JSON_CATEGORY;

@end
