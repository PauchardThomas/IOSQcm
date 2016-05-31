//
//  QcmWSAdapter.h
//  Qcm
//
//  Created by etudiant on 09/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QcmWSAdapter : NSObject

-(void) getQcms:(void(^)(NSMutableArray*))callback;
-(NSMutableArray*) extract:(NSDictionary* )json;

@end
