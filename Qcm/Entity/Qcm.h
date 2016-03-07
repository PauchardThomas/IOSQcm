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

@property(strong) NSManagedObjectID* id;
@property(strong) NSString* libelle;
@property(strong) NSDate* datePubli;
@property(strong) NSDate* dateFin;
@property(strong) NSNumber* nbPoints;
@property(strong) EntityCategory* categgory;


@end
