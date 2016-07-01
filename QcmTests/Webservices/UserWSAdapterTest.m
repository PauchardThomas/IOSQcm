//
//  UserWSAdapterTest.m
//  Qcm
//
//  Created by etudiant on 01/07/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UserWSAdapter.h"
#import "AFNetworking.h"
@interface UserWSAdapterTest : XCTestCase
@property(nonatomic) UserWSAdapter* userWSAdapter;
@end

@implementation UserWSAdapterTest

- (void)setUp {
    [super setUp];
    self.userWSAdapter = [UserWSAdapter new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testloginuser {
    
    //Create expectation
     XCTestExpectation* expectation = [self expectationWithDescription:@"mymethod"];
    // Create session
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    //Create request
    NSString* URL = UserWSAdapter.BASE_URL;
    NSDictionary* params = @{@"username": @"admin",
                             @"password": @"admin"};
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = serializer;
    
    
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSHTTPURLResponse* response = (NSHTTPURLResponse*) task.response;
        NSInteger statusCode = [response statusCode];
        XCTAssertEqual(200,statusCode);
        [expectation fulfill];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"ERROR : %@ ",error);
        NSHTTPURLResponse* response = (NSHTTPURLResponse*) task.response;
        NSInteger statusCode = [response statusCode];
        XCTAssertEqual(500,statusCode);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
