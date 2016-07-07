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

// Get categories from server
-(void) getCategories:(void(^)(NSMutableArray*))callback:(int)user_id;
// Extract json to category
-(NSMutableArray*) extract:(NSDictionary* )json;
// category libelle
+(NSString*) JSON_LIBELLE;
// category id server
+(NSString*) JSON_ID_SERVER;
// webservice category URL
+(NSString*) BASE_URL;


@end
