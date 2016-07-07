//
//  UserSqLiteAdapter.h
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface UserSqLiteAdapter : NSObject

// User entity
+(NSString*) ENTITY_USER;
// User username
+(NSString*) COL_USERNAME;
// User password
+(NSString*) COL_PASSWORD;
// User id server
+(NSString*) COL_ID_SERVER;

 // Inser user
-(NSManagedObjectID*)insert:(User*)user;
// Get all ser
-(NSArray*) getAll;
// Get user by id
-(NSManagedObject*)getById:(NSManagedObject *)user;
// Get user by id server
-(NSManagedObject*)getByIdServer:(User*)user;
// Get user by username and password
-(NSManagedObject*)getBy:(NSString*)username:(NSString*)password;
// Update user
-(void)update:(NSManagedObject*)managedObject withUser:(User*)user;
// Remove user
-(void)remove:(NSManagedObject*)managedObject;

@end
