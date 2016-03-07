//
//  CategorySqLiteAdapter.h
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category.h"

@interface CategorySqLiteAdapter : NSObject

-(void)insert:(EntityCategory*)category;
-(NSArray*) getAll;
-(NSManagedObject*)getById:(NSManagedObject *)category;
-(void)update:(NSManagedObject*)managedObject withCategory:(EntityCategory*)category;
-(void)remove:(NSManagedObject*)managedObject;

@end
