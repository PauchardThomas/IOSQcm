//
//  WeatherWSAdapter.h
//  Qcm
//
//  Created by etudiant on 08/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"
@interface WeatherWSAdapter : NSObject


+(NSString*) JSON_ID;
+(NSString*) JSON_DESCRIPTION;
+(NSString*) JSON_MAIN;
+(NSString*) JSON_WEATHER;
-(void) getWheater:(void(^)(Weather*))callback;
-(void) createWheater:(Weather*) weather withCallback:(void(^)(Weather*))callback;
-(void) updateWheater:(Weather*) weather withCallback:(void(^)(Weather*))callback;
-(Weather*) extract:(NSDictionary* )json;
-(NSDictionary*) itemToJson:(Weather*)weather;

@end
