//
//  Proposal.h
//  Qcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Question.h"

@interface Proposal : NSObject

@property(strong) NSManagedObjectID* id;
@property(strong) NSString* libelle;
@property Boolean* isAnswer;
@property(strong) Question* question;



@end
