//
//  UserWSAdapter.h
//  Qcm
//
//  Created by etudiant on 29/05/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface UserWSAdapter : NSObject

-(void) loginuser:(void(^)(User*))callbackUser:(NSString*)username:(NSString*)password;
-(User*) extract:(NSDictionary* )json;
+(NSString*) JSON_USERNAME;
+(NSString*) JSON_PASSWORD;
+(NSString*) JSON_ID_SERVER;
@end
