//
//  ToolClass.m
//  SwiftStudyBook
//
//  Created by TCS on 2022/9/15.
//  Copyright © 2022 tcs. All rights reserved.
//

#import "ToolClass.h"
#import "NSDictionary+DIcLog.h"

@implementation ToolClass

+(void)createPropetyCode:(NSDictionary*)dict{
    
    NSArray * arr = @[@"我的",@"他的"];
    NSString * nameStr = @"TCS";
    NSDictionary * peDict = @{@"keyName":@"阿乐",@"keyAge":@"18"};
    NSMutableDictionary * dadict = [NSMutableDictionary dictionaryWithCapacity:10];
    [dadict setValue:arr forKey:@"Arr"];
    [dadict setValue:nameStr forKey:@"nameStr"];
    [dadict setValue:peDict forKey:@"peDict"];
    [dadict setValue:dict forKey:@"dict"];

    [dadict createPropetyCode];
    
    
}
@end
