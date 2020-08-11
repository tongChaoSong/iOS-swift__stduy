//
//  TCSWEBHeader.h
//  SwiftStudyBook
//
//  Created by Apple on 2020/8/11.
//  Copyright © 2020 tcs. All rights reserved.
//

#ifndef TCSWEBHeader_h
#define TCSWEBHeader_h

//接口地址
#define IS_ONLINE  1     //1-online 2-localTest


#if   IS_ONLINE == 1
#define BASE @"http://api.ejyapi.com/cartrip_server"
#elif IS_ONLINE == 2
#define BASE @"http://192.168.1.199:9999/cartrip_server"
#elif IS_ONLINE == 3
#define BASE @"http://47.98.235.160:1883/cartrip_server"

#endif /* TCSWEBHeader_h */
