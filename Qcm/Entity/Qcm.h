//
//  Qcm.h
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Category.h"

@interface Qcm : NSObject

// Qcm id
@property(strong) NSManagedObjectID* id;
// Qcm libelle
@property(strong) NSString* libelle;
// Qcm datePubli
@property(strong) NSDate* datePubli;
// Qcm dateFin
@property(strong) NSDate* dateFin;
// Qcm duration
@property(strong) NSDate* duration;
// Qcm points
@property(strong) NSNumber* nbPoints;
// Qcm id server
@property(strong) NSNumber* id_server;
// Qcm category id
@property(strong) NSNumber* category_id;
// Qcm questions
@property(strong) NSArray* questions;


@end
