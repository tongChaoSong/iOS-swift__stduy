//
//  BlockHeader.h
//  SwiftStudyBook
//
//  Created by TCS on 2023/2/23.
//  Copyright © 2023 tcs. All rights reserved.
//

#ifndef BlockHeader_h
#define BlockHeader_h


typedef void(^DidSlectIndex)(NSInteger index,NSString *text);

typedef void(^VoidBlock)(void);

typedef void(^BoolBlock)(BOOL isbool);
//路由交互数据block
//typedef void(^TCSRouterBlock) (id backData);

#endif /* BlockHeader_h */
