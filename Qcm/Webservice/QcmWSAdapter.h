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

// Get qcms from server
-(void) getQcms:(void(^)(NSMutableArray*))callbackQcms:(int)category_id;

//Get only one qcm from server
-(void) getQcm:(void (^)(Qcm *))callbackQcm :(NSNumber*)qcm_id;

// extract all qcms from server response
-(NSMutableArray*) extract:(NSDictionary* )json;

// extract qcm from server response
-(Qcm*) extractQcm:(NSDictionary* )json;
// Qcm ID
+(NSString*) JSON_ID;
// Qcm libelle
+(NSString*) JSON_LIBELLE;
// Qcm duration
+(NSString*) JSON_DURATION;
// Qcm points
+(NSString*) JSON_NB_POINTS;
// Qcm category
+(NSString*) JSON_CATEGORY;
// webservice qcms URL
+(NSString*) BASE_URL;
// webservice qcm URL
+(NSString*) BASE_URL2;

@end
