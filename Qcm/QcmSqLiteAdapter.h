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

-(void)insert:(Qcm*)qcm;
-(NSArray*) getAll;
-(NSManagedObject*)getById:(NSManagedObject *)qcm;
-(void)update:(NSManagedObject*)managedObject withQcm:(Qcm*)qcm;
-(void)remove:(NSManagedObject*)managedObject;

@end
