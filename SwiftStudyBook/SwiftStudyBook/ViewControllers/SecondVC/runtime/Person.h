//
//  Person.h
//  SwiftStudyBook
//
//  Created by Apple on 2021/9/2.
//  Copyright © 2021 tcs. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject

@property(nonatomic,copy)NSString * name;
-(void)test;

+(Person*)newTest;

@end

