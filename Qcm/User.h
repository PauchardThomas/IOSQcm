//
//  User.h
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface User : NSObject

@property(strong) NSManagedObjectID* id;
@property(strong) NSString* username;
@property(strong) NSString* password;



@end
