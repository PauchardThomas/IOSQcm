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

-(void)insert:(User*)user;
-(NSArray*) getAll;
-(NSManagedObject*)getById:(NSManagedObject *)user;
-(void)update:(NSManagedObject*)managedObject withUser:(User*)user;
-(void)remove:(NSManagedObject*)managedObject;

@end
