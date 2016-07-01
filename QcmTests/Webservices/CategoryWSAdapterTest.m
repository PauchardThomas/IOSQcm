//
//  CategoryWSAdapterTest.m
//  Qcm
//
//  Created by etudiant on 01/07/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CategoryWSAdapter.h"
#import "AFNetworking.h"
@interface CategoryWSAdapterTest : XCTestCase
@property(nonatomic) CategoryWSAdapter* categoryWSAdapter;
@end

@implementation CategoryWSAdapterTest

- (void)setUp {
    [super setUp];
    CategoryWSAdapterTest* categoryWSAdapter = [CategoryWSAdapterTest new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testgetCategories {

    // Create expectation
    XCTestExpectation* expectation = [self expectationWithDescription:@"getCategories"];
    // Create session
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    //Create request
    NSString* URL = [NSString stringWithFormat:@"%@/%d",CategoryWSAdapter.BASE_URL,5];
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSHTTPURLResponse* response = (NSHTTPURLResponse*) task.response;
        NSInteger statusCode = [response statusCode];
        XCTAssertEqual(200,statusCode);
        [expectation fulfill];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error : %@",error);
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
