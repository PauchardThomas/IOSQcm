//
//  ProposalUser.h
//  Qcm
//
//  Created by etudiant on 27/06/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProposalUser : NSObject

// user id
@property(strong) NSNumber* user_id;
// qcm id
@property(strong) NSNumber* qcm_id;
// question id
@property(strong) NSNumber* question_id;
// proposal id
@property(strong) NSNumber* proposal_id;

@end
