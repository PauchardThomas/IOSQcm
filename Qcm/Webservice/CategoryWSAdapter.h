//
//  CategoryWSAdapter.h
//  Qcm
//
//  Created by etudiant on 08/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category.h"
@interface CategoryWSAdapter : NSObject

-(void) getCategories:(void(^)(NSMutableArray*))callback:(int)user_id;
-(NSMutableArray*) extract:(NSDictionary* )json;
+(NSString*) JSON_LIBELLE;
+(NSString*) JSON_ID_SERVER;
+(NSString*) BASE_URL;


@end
