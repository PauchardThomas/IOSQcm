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

// Get user from server
-(User*) loginuser:(void(^)(User*))callbackUser:(NSString*)username:(NSString*)password;

// Extract user from server response
-(User*) extract:(NSDictionary* )json;

// user username
+(NSString*) JSON_USERNAME;
// userpassword
+(NSString*) JSON_PASSWORD;
// user id server
+(NSString*) JSON_ID_SERVER;
// user webservice link
+(NSString*) BASE_URL;
@end
