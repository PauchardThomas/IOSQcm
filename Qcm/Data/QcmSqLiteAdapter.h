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

+(NSString*) ENTITY_QCM;
+(NSString*) COL_LIBELLE;
+(NSString*) COL_DATE_PUBLI;
+(NSString*) COL_DATE_FIN;
+(NSString*) COL_DURATION;
+(NSString*) COL_NB_POINTS;
+(NSString*) COL_ID_CATEGORY;


-(void)insert:(Qcm*)qcm;
//-(NSManagedObject*)insert:(Qcm*)qcm withCategory:(NSManagedObject*)category;
-(NSArray*) getAll;
-(NSManagedObject*)getById:(NSManagedObject *)qcm;
-(NSManagedObject*)getByIdServer:(Qcm*)qcm;
-(void)update:(NSManagedObject*)managedObject withQcm:(Qcm*)qcm;
-(void)remove:(NSManagedObject*)managedObject;

@end
