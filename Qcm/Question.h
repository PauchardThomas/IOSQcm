//
//  Question.h
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Qcm.h"

@interface Question : NSObject

@property(strong) NSManagedObjectID* id;
@property(strong) NSString* libelle;
@property(strong) NSNumber* points;
@property(strong) Qcm* qcm;



@end
