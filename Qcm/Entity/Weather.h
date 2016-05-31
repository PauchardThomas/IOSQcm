//
//  Weather.h
//  Qcm
//
//  Created by etudiant on 08/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property(nonatomic) int idServer;
@property(nonatomic,strong) NSString* description;
@property(nonatomic,strong) NSString* main;

@end
