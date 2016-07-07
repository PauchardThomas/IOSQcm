//
//  QcmSqLiteAdapter.h
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Qcm.h"

@interface QcmSqLiteAdapter : NSObject

// Qcm entity
+(NSString*) ENTITY_QCM;
// Qcm libelle
+(NSString*) COL_LIBELLE;
// Qcm date publi
+(NSString*) COL_DATE_PUBLI;
// Qcm date fin
+(NSString*) COL_DATE_FIN;
// Qcm duration
+(NSString*) COL_DURATION;
// Qcm  duration
+(NSString*) COL_NB_POINTS;
// Qcm  category
+(NSString*) COL_ID_CATEGORY;
// Qcm  id server
+(NSString*) COL_ID_SERVER;

// Insert qcm
-(void)insert:(Qcm*)qcm;
// Get all qcm
-(NSArray*) getAll;
// Get qcm by id
-(NSManagedObject*)getById:(NSManagedObject *)qcm;
// get qcm by id server
-(NSManagedObject*)getByIdServer:(Qcm*)qcm;
// update qcm
-(void)update:(NSManagedObject*)managedObject withQcm:(Qcm*)qcm;
// remove qcm
-(void)remove:(NSManagedObject*)managedObject;

@end
