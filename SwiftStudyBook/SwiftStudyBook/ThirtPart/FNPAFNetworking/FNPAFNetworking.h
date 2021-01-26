

//
//  FNPAFNetworking.h
//  homePgeProject
//
//  Created by Apple on 2021/1/25.
//  Copyright © 2021 tcs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Availability.h>
#import <TargetConditionals.h>

#ifndef _FNPAFNETWORKING_
    #define _FNPAFNETWORKING_

    #import "FNPAFURLRequestSerialization.h"
    #import "FNPAFURLResponseSerialization.h"
    #import "FNPAFSecurityPolicy.h"

#if !TARGET_OS_WATCH
    #import "FNPAFNetworkReachabilityManager.h"
#endif

    #import "FNPAFURLSessionManager.h"
    #import "FNPAFHTTPSessionManager.h"

#endif /* _AFNETWORKING_ */
