//
//  WeatherWSAdapter.m
//  Qcm
//
//  Created by etudiant on 08/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "WeatherWSAdapter.h"
#import "AFNetworking.h"

@implementation WeatherWSAdapter

+(NSString*) JSON_ID{ return @"id";}
+(NSString*) JSON_DESCRIPTION{return @"description";}
+(NSString*) JSON_MAIN {return @"main";}
+(NSString*) JSON_WEATHER {return @"weather";}

-(void) getWheater:(void(^)(Weather*))callback {
    
    // Create session
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    //Create request
    NSString* URL = @"http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=44db6a862fba0b067b1930da0d769e98";
    
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        Weather* weather = [self extract:responseObject];
        callback(weather);
        NSLog(@"JSON : %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        callback(nil);
        NSLog(@"Error : %@",error);
    }];

    
}

-(void) createWheater:(Weather*) weather withCallback:(void(^)(Weather*))callback {
    
    // Create session
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    //Create request
    NSString* URL = @"http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=44db6a862fba0b067b1930da0d769e98";
    
    [manager POST:URL parameters:[self itemToJson:weather] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(weather);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(error);
        callback(nil);
    }];
    
}

-(void) updateWheater:(Weather*) weather withCallback:(void(^)(Weather*))callback {
    
    // Create session
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    //Create request
    NSString* URL = @"http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=44db6a862fba0b067b1930da0d769e98";
    
    [manager PUT:URL parameters:[self itemToJson:weather] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(weather);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(nil);
    }];
    

}

-(Weather*) extract:(NSDictionary* )json{

    Weather* weather = [Weather new];
    if (json != nil) {
       // ArraList en android = NSArray
        NSArray* weathers = [json objectForKey:WeatherWSAdapter.JSON_WEATHER];
        //  un flux json est un NSDictionary
        // on récupère l'id 0 cr y'en a qu'un sinon boucle for
        NSDictionary* weatherDic = [weathers objectAtIndex:0];
        
        weather.idServer = [[weatherDic objectForKey:WeatherWSAdapter.JSON_ID]intValue];
        weather.description = [weatherDic objectForKey:WeatherWSAdapter.JSON_DESCRIPTION];
        weather.main = [weatherDic objectForKey:WeatherWSAdapter.JSON_MAIN];
    }
    return weather;
    
}

-(NSDictionary*) itemToJson:(Weather*)weather{
    
    NSDictionary* json = nil;
    
    if (weather != nil) {
        // inverse de android : 1er object et ensuite key
        json = [NSDictionary dictionaryWithObjectsAndKeys:
               [NSNumber numberWithInt:weather.idServer],WeatherWSAdapter.JSON_ID,
                weather.description, WeatherWSAdapter.JSON_DESCRIPTION,
                weather.main,WeatherWSAdapter.JSON_MAIN, nil];
        
    }
    
    return json;
}


@end
